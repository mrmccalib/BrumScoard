class TasksController < ApplicationController
    def new
        @task = Task.new
    end

    def create
        current_board.task_columns.first.tasks.each do |task|
            task.position += 1
            task.save
        end
        @task = Task.new(task_params)
        if current_user_role != Membership.roles[:developer]
            flash[:danger] = "Only developers can add tasks!"
            render 'new'
        elsif @task.weight
            if @task.weight > 100 or @task.weight < 0
                flash.now[:danger] = "Weight must be between 0 and 100!"
                render 'new'
            elsif current_story.tasks.sum(:weight) + @task.weight > 100
                flash.now[:danger] = "Total weight for this story must not exceed 100. Reduce the weight for other tasks first!"
                render 'new'
            end
        end
        if @task.save
            flash[:success] = "Task added!"
            redirect_to current_board
        else
            render 'new'
        end
    end

    def edit
        @task = current_task
    end

    def update
        @task = current_task
        oldWeight = @task.weight
        oldWeight = 0 if oldWeight.nil?
        newWeight = task_params[:weight].to_i
        if newWeight
            if newWeight > 100 or newWeight < 0
                flash.now[:danger] = "Weight must be between 0 and 100!"
                render 'new'
                return
            elsif current_story.tasks.sum(:weight) - oldWeight + newWeight > 100
                flash.now[:danger] = "Total weight for this story must not exceed 100. Reduce the weight for other tasks first!"
                render 'new'
                return
            end
        end

        @task.update_attributes(task_params)
        if @task.save
            flash[:success] = "Task edited!"
            redirect_to current_board
        else
            render 'new'
        end
    end

    private

    def task_params
        params.require(:task).permit(:description, :weight, :position, :task_column_id, :story_id, :user_id)
    end

end
