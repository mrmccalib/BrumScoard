class BoardsController < ApplicationController

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)
        if @board.save
            user = User.find(session[:user_id])
            # add to lookup table
            @board.users << user
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


        if oldCol == 0
          puts "%*%*%*%*%*%*%%OLDCOL EQUALS ZERO%*%*%*%*%*%*%%*"
          puts "newCol = #{newCol}"
          puts "oldIndex = #{oldIndex}"
        end

        if newCol == 1
          puts "((((((((((((((((((((((newcol = 1))))))))))))))))))))))"
        end

        if oldIndex != 0
          puts '______________________oldIndex != 0_____________________'
        end

        if oldCol == 0 and newCol == 1 and oldIndex != 0
            flash[:danger] = "Can only move top item in Product Backlog!"
            puts '@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$@#$'
            redirect_to :back
        end

        boardAtOldIndex = (@board.stories.select {|story| story.position == oldIndex}).first

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
        boardAtOldIndex.position = newIndex
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
            current_board.users << user
            flash[:success] = "User added!"
        end
        redirect_to :back
    end

    private

    def board_params
        params.require(:board).permit(:name, :description)
    end

    def invitation_params
        params.require(:invitation).permit(:name, :description)
    end


end
