module SprintsHelper

    # def current_board
    #     Board.find(params[:id])
    # end
    #
    # def current_user_role
    #     Membership.roles[Membership.find_by(board_id: current_board.id, user_id: current_user.id).role]
    # end

    def latest_sprint
        board = Board.find(params[:id]) #current board
        board.sprints.first
    end

    def current_sprint
        # board = Board.find(params[:id]) #current board
        Sprint.find(params[:sprint_id])
    end

end
