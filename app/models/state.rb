class State < ApplicationRecord
    belongs_to :board
    has_many :sprints

    def deep_dup
        self_dup = State.create(self.dup.attributes)
        sprints.each do |sprint|
            self_dup.sprints << sprint.deep_dup
        end
        return self_dup
    end
end
