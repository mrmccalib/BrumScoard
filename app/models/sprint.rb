class Sprint < ApplicationRecord
    belongs_to :board

    has_many :story_columns
    has_many :task_columns
end
