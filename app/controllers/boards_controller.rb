class BoardsController < ApplicationController

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)
        sprint = Sprint.create()
        @board.sprints << sprint
        sprint.story_columns << StoryColumn.create(name: 'Product Backlog', position:0)
        sprint.story_columns << StoryColumn.create(name: 'Sprint Backlog',  position:1)
        sprint.task_columns << TaskColumn.create(name: 'To Do', position: 2)
        sprint.task_columns << TaskColumn.create(name: 'Doing', position: 3)
        sprint.task_columns << TaskColumn.create(name: 'Done',  position: 4)
        if @board.save
            user = User.find(session[:user_id])
            membership = Membership.new(board_id: @board.id, user_id: user.id, role: :developer)
            membership.save
            flash[:success] = "Board created!"
            redirect_to boards_url
        else
            render 'new'
        end
    end

    def show
        @board = Board.find(params[:id])
        session[:sprint_id] = current_sprint.id
    end

    def index
    end

    def stories_update
        sprint = current_sprint
        if sprint != current_board.sprints.last
            render :json => {
                :message => "Only the current sprint is editable!"
            }
            return
        end

        storyAtOldIndex = Story.find(params[:itemID].to_i)
        oldIndex = storyAtOldIndex.position
        newIndex = params[:newIndex].to_i
        oldCol = (sprint.story_columns.select {|story_column| story_column.position == params[:oldCol].to_i}).first
        newCol = (sprint.story_columns.select {|story_column| story_column.position == params[:newCol].to_i}).first

        if current_user_role != Membership.roles[:product_owner]
            render :json => {
                :message => "Only a product owner can move stories!"
            }
            return
        elsif oldCol.position == 0 and newCol.position == 1 and oldIndex != 0
            render :json => {
                :message => "Can only move top item in Product Backlog!"
            }
            return
        elsif newCol.position == 2 or newCol.position == 3 or newCol.position == 4
            render :json => {
                :message => "Only tasks can go in that column!"
            }
            return
        end

        if oldCol == newCol
            if oldIndex < newIndex # moving down in the list
                (oldCol.stories.select {|story| story.position <= newIndex and story.position > oldIndex}).each do |story|
                    story.position -= 1
                    story.save
                end
            else # moving up in the list
                (oldCol.stories.select {|story| story.position >= newIndex and story.position < oldIndex}).each do |story|
                    story.position += 1
                    story.save
                end
            end
        else #moving between columns
            (oldCol.stories.select {|story| story.position > oldIndex}).each do |story|
                story.position -= 1
                story.save
            end
            (newCol.stories.select {|story| story.position >= newIndex}).each do |story|
                story.position += 1
                story.save
            end
        end

        storyAtOldIndex.position = newIndex
        storyAtOldIndex.save
        if oldCol != newCol
            newCol.stories << storyAtOldIndex
            oldCol.stories.delete(storyAtOldIndex)
        end
    end


    def tasks_update
        sprint = current_sprint
        if sprint != current_board.sprints.last
            render :json => {
                :message => "Only the current sprint is editable!"
            }
            return
        end
        taskAtOldIndex = Task.find(params[:itemID].to_i)
        oldIndex = taskAtOldIndex.position
        newIndex = params[:newIndex].to_i
        oldCol = (sprint.task_columns.select {|task_column| task_column.position == params[:oldCol].to_i}).first
        newCol = (sprint.task_columns.select {|task_column| task_column.position == params[:newCol].to_i}).first

        if current_user_role != Membership.roles[:developer]
            render :json => {
                :message => "Only a developer can move tasks!"
            }
            return
        elsif newCol.position == 0 or newCol.position == 1
            render :json => {
                :message => "Only stories can go in that column!"
            }
            return
        elsif oldCol.position == 2 and newCol.position > oldCol.position
            if taskAtOldIndex.weight.nil?
                render :json => {
                    :message => "Tasks must have a weight before being moved from To Do!"
                }
                return
            elsif taskAtOldIndex.user_id.nil?
                render :json => {
                    :message => "Tasks must have a developer assigned before being moved from To Do!"
                }
                return
            end
        end

        if oldCol == newCol
            if oldIndex < newIndex # moving down in the list
                (oldCol.tasks.select {|task| task.position <= newIndex and task.position > oldIndex}).each do |task|
                    task.position -= 1
                    task.save
                end
            else # moving up in the list
                (oldCol.tasks.select {|task| task.position >= newIndex and task.position < oldIndex}).each do |task|
                    task.position += 1
                    task.save
                end
            end
        else #moving between columns
            (oldCol.tasks.select {|task| task.position > oldIndex}).each do |task|
                task.position -= 1
                task.save
            end
            (newCol.tasks.select {|task| task.position >= newIndex}).each do |task|
                task.position += 1
                task.save
            end
        end

        taskAtOldIndex.position = newIndex
        taskAtOldIndex.save
        if oldCol != newCol
            newCol.tasks << taskAtOldIndex
            oldCol.tasks.delete(taskAtOldIndex)
        end

        # tell ajax to update weight
        if (oldCol.position == 4 or newCol.position == 4 ) and newCol.position != oldCol.position
            completion = completion(taskAtOldIndex.story)
            if completion != 'No tasks created'
                render :json => {
                    :story => taskAtOldIndex.story.id.to_s,
                    :completion => completion
                }
            end
        end
    end


    def send_invitation
        username = params[:invitation][:username]
        invitee = User.find_by(username: username)
        members = User.joins(:memberships).where(memberships: {board_id: current_board.id})
        invited = User.joins(:invitations).where(invitations: {board_id: current_board.id})
        if !invitee
            flash[:danger] = "Must enter a valid user!"
        elsif !members.include?(current_user)
            flash[:danger] = "You must be a member of this project to invite users!"
        elsif members.include?(invitee)
            flash[:danger] = "User is already a member!"
        elsif invited.include?(invitee)
            flash[:danger] = "User has already been invited!"
        else
            invitation = Invitation.new(board_id: current_board.id, user_id: invitee.id, role: params[:invitation][:role])
            invitation.save
            flash[:success] = "User invited!"
        end
        redirect_to :back
    end

    def join
        user_id = params[:user_id]
        if current_user.id != user_id.to_i #only true if user is a jerk
            puts "user_id: #{user_id.class.name}, current_user.id: #{current_user.id.class.name}"
            flash[:danger] = "You must be invited to a board before joining it!"
            redirect_to :back
        end
        board_id = params[:board_id]
        invitation = Invitation.find_by(board_id: board_id, user_id: user_id)
        membership = Membership.new(board_id: board_id, user_id: user_id, role: invitation.role);
        invitation.destroy
        membership.save
        flash[:success] = 'Project joined!'
        redirect_to :back
    end

    def reject
        user_id = params[:user_id]
        if current_user.id != user_id.to_i #only true if user is a jerk
            puts "user_id: #{user_id.class.name}, current_user.id: #{current_user.id.class.name}"
            flash[:danger] = "That is not your invitation to reject!"
            redirect_to :back
        end
        board_id = params[:board_id]
        invitation = Invitation.find_by(board_id: board_id, user_id: user_id)
        invitation.destroy
        flash[:success] = 'Invitation rejected! (You sure showed them!)'
        redirect_to :back
    end

    private

    def board_params
        params.require(:board).permit(:name, :description)
    end

    def invitation_params
        params.require(:invitation).permit(:username, :role)
    end


end
