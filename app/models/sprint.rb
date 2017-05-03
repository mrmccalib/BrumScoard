class Sprint < ApplicationRecord
    belongs_to :state

    has_many :story_columns
    has_many :task_columns

    def deep_dup
        self_dup = Sprint.create(self.dup.attributes)
        story_columns.each do |story_column|
            self_dup.story_columns << story_column.deep_dup
        end
        task_columns.each do |task_column|
            self_dup.task_columns << task_column.deep_dup
        end
        return self_dup
    end
end
