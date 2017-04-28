class BoardsController < ApplicationController

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)
        if @board.save
            user = User.find(session[:user_id])
            # add to lookup table
            membership = Membership.new(board_id: @board.id, user_id: user.id, role: :developer)
            membership.save
            # @board.users << user
            flash[:success] = "Board created!"
            redirect_to boards_url
        else
            render 'new'
        end
    end

    def show
        @board = Board.find(params[:id])
        session[:board_name] = @board.name
    end

    def index
        # @board = current_board
    end

    def stories_update
        @board = current_board
        storyID = params[:itemID].to_i
        storyAtOldIndex = Story.find(storyID)
        oldIndex = storyAtOldIndex.position
        oldCol = storyAtOldIndex.column
        # oldIndex = params[:oldIndex].to_i
        # oldCol = params[:oldCol].to_i
        newIndex = params[:newIndex].to_i
        newCol = params[:newCol].to_i


        if current_user_role != Membership.roles[:product_owner]
            render :json => {
                :message => "Only a product owner can move stories!"
            }
            return
        end
        if oldCol == 0 and newCol == 1
            if oldIndex != 0
                render :json => {
                    :message => "Can only move top item in Product Backlog!"
                }
                return
            end
        end
        if newCol == 2 or newCol == 3 or newCol == 4
            render :json => {
                :message => "Only tasks can go in that column!"
            }
            return
        end

        storyAtOldIndex = (@board.stories.select {|story| story.position == oldIndex and story.column == oldCol}).first

        if oldCol == newCol
            if oldIndex < newIndex # moving down in the list
                (@board.stories.select {|story| story.position <= newIndex and story.position > oldIndex}).each do |story|
                    story.position -= 1
                    story.save
                end
            else # moving up in the list
                (@board.stories.select {|story| story.position >= newIndex and story.position < oldIndex}).each do |story|
                    story.position += 1
                    story.save
                end
            end
        else #oldCol == 0 and newCol == 1
            (@board.stories.select {|story| story.column == oldCol and story.position > oldIndex}).each do |story|
                story.position -= 1
                story.save
            end
            (@board.stories.select {|story| story.column == newCol and story.position >= newIndex}).each do |story|
                story.position += 1
                story.save
            end
        end

        storyAtOldIndex.position = newIndex
        storyAtOldIndex.column = newCol
        storyAtOldIndex.save
    end


    def tasks_update
        @board = current_board
        taskID = params[:itemID].to_i
        taskAtOldIndex = Task.find(taskID)
        oldIndex = taskAtOldIndex.position
        oldCol = taskAtOldIndex.column
        # oldIndex = params[:oldIndex].to_i
        # oldCol = params[:oldCol].to_i
        newIndex = params[:newIndex].to_i
        newCol = params[:newCol].to_i

        if current_user_role != Membership.roles[:developer]
            render :json => {
                :message => "Only a developer can move tasks!"
            }
            return
        elsif newCol == 0 or newCol == 1
            render :json => {
                :message => "Only stories can go in that column!"
            }
            return
        end

        if oldCol == newCol
            if oldIndex < newIndex # moving down in the list
                @board.stories.each do |story|
                    (story.tasks.select {|task| task.position <= newIndex and task.position > oldIndex}).each do |task|
                        task.position -= 1
                        task.save
                    end
                end
            else # moving up in the list
                @board.stories.each do |story|
                    (story.tasks.select {|task| task.position >= newIndex and task.position < oldIndex}).each do |task|
                        task.position += 1
                        task.save
                    end
                end
            end
        else #oldCol == 0 and newCol == 1
            @board.stories.each do |story|
                (story.tasks.select {|task| task.column == oldCol and task.position > oldIndex}).each do |task|
                    task.position -= 1
                    task.save
                end
            end
            @board.stories.each do |story|
                (story.tasks.select {|task| task.column == newCol and task.position >= newIndex}).each do |task|
                    task.position += 1
                    task.save
                end
            end
        end

        taskAtOldIndex.position = newIndex
        taskAtOldIndex.column = newCol
        taskAtOldIndex.save
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
