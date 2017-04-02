class StoriesController < ApplicationController
    def new
        @story = Story.new
    end

    def create
        @story = Story.new(story_params)
        if @story.save
            flash[:success] = "Story added successfully!"
            redirect_to current_board
        else
            render 'new'
        end

    end

    def show
    end

    private

    def story_params
        params.require(:story).permit(:description, :as, :want, :so_that, :criteria, :size, :board_id)
    end

end
