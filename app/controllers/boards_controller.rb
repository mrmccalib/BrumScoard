

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
        @board = current_board
    end

    def send_invitation
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
