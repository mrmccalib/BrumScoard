class StatesController < ApplicationController

    def create
        state = active_state(current_board).deep_dup
        state.active = false
        current_board.states << state
        flash[:success] = 'State copied!'
        redirect_to board_path(current_board.id, current_state.id, current_sprint.id)
    end

end
