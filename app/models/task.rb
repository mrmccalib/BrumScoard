class Task < ApplicationRecord

    belongs_to :story
    belongs_to :user

    validates :weight, :numericality => {:only_integer => true}
    validate :required_fields

    private

    def required_fields
        if(description.blank?)
          errors.add(:base, "Must enter description!")
        end
    end
end
