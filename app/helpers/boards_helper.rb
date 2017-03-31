module BoardsHelper

    def current_board
        Board.find_by(name: session[:board_name])
    end
end
