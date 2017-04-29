module StoriesHelper
    def current_story
        Story.find(params[:story_id])
    end

    def completion(story)
        puts story.description
        doneColumn = (current_board.task_columns.select {|task_column| task_column.position == 4}).first
        doneTasks = doneColumn.tasks.select {|task| task.story_id == story.id}
        # numDone = doneTasks ? doneTasks.count : 0
        # numTasks = story.tasks.any? ? story.tasks.count : 0
        doneWeight = 0
        totalWeight = 0
        doneTasks.each do |task|
            doneWeight += task.weight unless task.weight.nil?

        end
        story.tasks.each do |task|
            totalWeight += task.weight unless task.weight.nil?
        end
        if !story.tasks.any?
            return 'no tasks created'
        elsif totalWeight == 0
            return "tasks have no weight"
        else
            return (doneWeight).to_s + "%"
        end
    end
end
