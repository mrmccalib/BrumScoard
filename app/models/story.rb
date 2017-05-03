class Story < ApplicationRecord

    belongs_to :story_column
    has_many :tasks

    validate :required_fields

    def deep_dup
        self_dup = Story.create(self.dup.attributes)
        # tasks.each do |task|
        #     task_dup = task.dup
        #     self_dup.tasks << task_dup
        #     sprint_dup = self_dup.story_column.sprint
        #     puts '**********************************************************************************************'
        #     puts sprint_dup.id
        #
        #     col_for_task_dup = (sprint_dup.task_columns.select {|task_column| task_column.position == task.task_column.position }).first
        #     col_for_task_dup.tasks << task_dup
        # end
        return self_dup
    end


    private

    def required_fields
        if (description.blank? and (as.blank? or want.blank? or so_that.blank?))
            errors.add(:base, "Must enter either description or fill template!")
        end
    end
end
