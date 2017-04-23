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

    def list_update
        @board = current_board
        oldIndex = params[:oldIndex].to_i
        newIndex = params[:newIndex].to_i
        oldCol = params[:oldCol].to_i
        newCol = params[:newCol].to_i


        if oldCol == 0 and newCol == 1
            puts current_user_role
            if oldIndex != 0
                render :json => {
                    :message => "Can only move top item in Product Backlog!"
                }
                return
            elsif Membership.roles[current_user_role] != Membership.roles[:product_owner]
                render :json => {
                    :message => "Only a product owner can move items from the Product Backlog!"
                }
                return
            end
        end

        boardAtOldIndex = (@board.stories.select {|story| story.position == oldIndex and story.column == oldCol}).first

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
        elsif oldCol == 0 and newCol == 1
            (@board.stories.select {|story| story.column == oldCol}).each do |story|
                story.position -= 1
                story.save
            end
            (@board.stories.select {|story| story.column == newCol and story.position >= newIndex}).each do |story|
                story.position += 1
                story.save
            end
        end

        boardAtOldIndex.position = newIndex
        boardAtOldIndex.column = newCol
        boardAtOldIndex.save
    end

    def send_invitation
      #  @board = current_board
        username = params[:invitation][:username]
        user = User.find_by(username: username)
        if !user
            flash[:danger] = "Must enter a valid user!"
        elsif !current_board.users.include?(current_user)
            flash[:danger] = "You must be a member of this project to invite users!"
        elsif current_board.users.include?(user)
            flash[:danger] = "User is already a member!"
        else
            # current_board.users << user
            membership = Membership.new(board_id: current_board.id, user_id: user.id, role: params[:invitation][:role])
            membership.save
            flash[:success] = "User added!"
        end
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
