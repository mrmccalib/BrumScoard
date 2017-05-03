module BoardsHelper

    def current_board
        Board.find(params[:id])
    end

    def current_user_role
        Membership.roles[Membership.find_by(board_id: current_board.id, user_id: current_user.id).role]
    end

    def active_state(board)
        (board.states.select {|state| state.active == true}).first
    end
end
