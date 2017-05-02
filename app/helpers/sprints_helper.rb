module SprintsHelper

    def latest_sprint
        board = Board.find(params[:id]) #current board
        board.sprints.first
    end

    def current_sprint
        # board = Board.find(params[:id]) #current board
        Sprint.find(params[:sprint_id])
    end

end
