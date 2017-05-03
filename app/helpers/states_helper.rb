module StatesHelper


    def current_state
        Sprint.find(params[:state_id])
    end

end
