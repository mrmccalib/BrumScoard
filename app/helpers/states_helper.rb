module StatesHelper


    def current_state
        State.find(params[:state_id])
    end

end
