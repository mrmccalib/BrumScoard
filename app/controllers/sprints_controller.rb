class SprintsController < ApplicationController

    def create
        sprint = Sprint.create(number: current_sprint.number + 1)
        pbl = StoryColumn.create(name: 'Product Backlog', position:0)
        sprint.story_columns << pbl
        sprint.story_columns << StoryColumn.create(name: 'Sprint Backlog',  position:1)
        sprint.task_columns << TaskColumn.create(name: 'To Do', position: 2)
        sprint.task_columns << TaskColumn.create(name: 'Doing', position: 3)
        sprint.task_columns << TaskColumn.create(name: 'Done',  position: 4)
        current_sprint.story_columns.first.stories.each do |story| # take from prduct backlog
            pbl.stories << story.dup
        end
        current_sprint.story_columns.last.stories.each do |story| # take unaccepted from sprint backlog
            if story.acceptance.nil? or story.acceptance == false
                storyClone = story.dup
                storyClone.acceptance = nil
                storyClone.rejection_reason = nil
                storyClone.position = 0
                pbl.stories.each do |pbl_story|
                    pbl_story.position += 1
                end
                pbl.stories << storyClone
                # storyClone.save
            end
        end
        active_state(current_board).sprints << sprint
        redirect_to board_path(current_board.id, current_state.id, sprint.id)
    end

end
