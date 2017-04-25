class Task < ApplicationRecord

    belongs_to :story
    belongs_to :user

    validate :required_fields
    validate :weight_sum


    private

    def required_fields
        if(description.blank?)
          errors.add(:base, "Must enter description!")
        end
    end
end
