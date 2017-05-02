class StoryColumn < ApplicationRecord

    belongs_to :sprint
    has_many :stories, -> {order 'position asc'}

    validate :required_fields

    private

    def required_fields
        if (name.blank?)
            errors.add(:base, "Must enter name!")
        end
    end
end
