class TaskColumn < ApplicationRecord

    belongs_to :sprint
    has_many :tasks, -> {order 'position asc'}

    validate :required_fields

    def deep_dup
        self_dup = TaskColumn.create(self.dup.attributes)
        # tasks.each do |task|
        #     self_dup.tasks << task.deep_dup
        # end
        return self_dup
    end


    private

    def required_fields
        if (name.blank?)
            errors.add(:base, "Must enter name!")
        end
    end
end
