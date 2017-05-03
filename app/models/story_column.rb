class StoryColumn < ApplicationRecord

    belongs_to :sprint
    has_many :stories, -> {order 'position asc'}

    validate :required_fields

    def deep_dup
        self_dup = StoryColumn.create(self.dup.attributes)
        stories.each do |story|
            self_dup.stories << story.deep_dup
        end
        return self_dup
    end

    private

    def required_fields
        if (name.blank?)
            errors.add(:base, "Must enter name!")
        end
    end
end
