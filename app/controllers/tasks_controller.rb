class TasksController < ApplicationController
    def new
        @task = Task.new
    end

    def create
        current_story.tasks.each do |task|
            task.position += 1
            task.save
        end
        @task = Task.new(task_params)
        if current_user_role != Membership.roles[:developer]
            flash[:danger] = "Only developers can add tasks!"
            render 'new'
        elsif @task.weight
            if @task.weight > 100 or @task.weight < 0
                flash[:danger] = "Weight must be between 0 and 100!"
                render 'new'
            elsif current_story.tasks.sum(:weight) + @task.weight > 100
                flash[:danger] = "Total weight for this story must not exceed 100. Reduce the weight for other tasks first!"
                render 'new'
            end
        end
        if @task.save
            flash[:success] = "Task added!"
            redirect_to current_board
        else
            flash[:danger] = "OH NO! Task could not be added!"
            render 'new'
        end
    end

    def edit
        @task = current_task
    end

    def update
        @task = current_task
        @task.update_attributes(task_params)
        if @task.weight
            if @task.weight > 100 or @task.weight < 0
                flash[:danger] = "Weight must be between 0 and 100!"
                render 'new'
                return
            elsif current_story.tasks.sum(:weight) + @task.weight > 100
                flash[:danger] = "Total weight for this story must not exceed 100. Reduce the weight for other tasks first!"
                render 'new'
                return
            end
        end

        if @task.save
            flash[:success] = "Task edited!"
            redirect_to current_board
        else
            flash[:danger] = "OH NO! Task could not be edited!"
            render 'new'
        end
    end


    private

    def task_params
        params.require(:task).permit(:description, :weight, :position, :column, :story_id, :user_id)
    end

end
