module StoriesHelper
    def current_story
        Story.find(params[:story_id])
    end
end
