class Task < ApplicationRecord

    belongs_to :story
    belongs_to :task_column
    belongs_to :user

    validates :weight, :numericality => {:only_integer => true}, :allow_nil => true
    validate :required_fields

    private

    def required_fields
        if(description.blank?)
          errors.add(:base, "Must enter description!")
        end
    end
end
