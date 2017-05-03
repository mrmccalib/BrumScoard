class Sprint < ApplicationRecord
    belongs_to :state

    has_many :story_columns
    has_many :task_columns

    def deep_dup
        self_dup = Sprint.create(self.dup.attributes)
        task_columns.each do |task_column|
            self_dup.task_columns << task_column.dup
        end
        story_columns.each do |story_column|
            story_column_dup = story_column.deep_dup
            self_dup.story_columns << story_column_dup
            story_column.stories.each do |story|
                story.tasks.each do |task|
                    task_dup = task.dup
                    story_for_task_dup = (story_column_dup.stories.select {|story_dup| task.story.attributes.except('id', 'story_column_id') == story_dup.attributes.except('id', 'story_column_id') }).first
                    story_for_task_dup.tasks << task_dup
                    col_for_task_dup = (self_dup.task_columns.select {|task_column| task_column.position == task.task_column.position }).first
                    col_for_task_dup.tasks << task_dup
                end
            end
        end
        return self_dup
    end
end
