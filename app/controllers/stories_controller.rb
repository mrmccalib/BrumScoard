class StoriesController < ApplicationController
    #not sure why we need this line here and not in the other controllers
    include StoriesHelper

    def new
        @story = Story.new
    end

    def create
        current_board.story_columns.first.stories.each do |story|
            story.position += 1
            story.save
        end
        @story = Story.new(story_params)
        if current_user_role != Membership.roles[:developer]
            flash.now[:danger] = "Only developers can add stories!"
            render 'new'
        elsif @story.save
            flash[:success] = "Story added!"
            redirect_to current_board
        else
            render 'new'
        end
    end

    def edit
        @story = current_story
    end

    def update
        @story = current_story
        @story.update_attributes(story_params)
        if @story.save
            flash[:success] = "Story edited!"
            redirect_to current_board
        else
            render 'new'
        end
    end

    def show
    end

    private

    def story_params
        params.require(:story).permit(:description, :as, :want, :so_that, :criteria, :size, :story_column_id, :position)
    end

end
