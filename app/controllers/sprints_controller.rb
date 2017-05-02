class SprintsController < ApplicationController

    def create
        sprint = Sprint.create()
        pbl = StoryColumn.create(name: 'Product Backlog', position:0)
        sprint.story_columns << pbl
        sprint.story_columns << StoryColumn.create(name: 'Sprint Backlog',  position:1)
        sprint.task_columns << TaskColumn.create(name: 'To Do', position: 2)
        sprint.task_columns << TaskColumn.create(name: 'Doing', position: 3)
        sprint.task_columns << TaskColumn.create(name: 'Done',  position: 4)
        current_sprint.story_columns.first.stories.each do |story| # take from prduct backlog
            pbl.stories << story.clone
        end
        current_sprint.story_columns.last.stories.each do |story| # take unaccepted from sprint backlog
            if story.acceptance.nil? or story.acceptance == false
                storyClone = story.clone
                storyClone.acceptance = nil
                story.rejection_reason = nil
                pbl.stories << story.clone
            end
        end
        current_board.sprints << sprint
        if sprint.save
            redirect_to board_path(current_board.id, sprint.id)
        end
    end

end
