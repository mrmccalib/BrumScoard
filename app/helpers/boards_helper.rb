module BoardsHelper

    def current_board
        Board.find(params[:id])
    end
end
