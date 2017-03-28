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
    end

    def index
    end

    private

    def board_params
        params.require(:board).permit(:name, :description)
    end

end
