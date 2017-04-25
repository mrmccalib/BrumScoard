class Story < ApplicationRecord

    belongs_to :board
    has_many :tasks

    validate :required_fields

    private

    def required_fields
        if (description.blank? and (as.blank? or want.blank? or so_that.blank?))
            errors.add(:base, "Must enter either description or fill template!")
        end
    end
end
