class StatesController < ApplicationController

    def create
        state = active_state(current_board).deep_dup
        state.active = false
        current_board.states << state
        flash[:success] = 'State copied!'
        puts "board: #{current_board}, state: #{current_state}, sprint: #{current_sprint}"
        redirect_to board_path(current_board.id, current_state.id, current_sprint.id)
    end

    def latest_sprint
        render :json => {
            :sprint_id => current_state.sprints.last.id
        }
    end

end
