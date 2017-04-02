class Story < ApplicationRecord

    private

    def required_fields
        if !(description or (as and want and so_that))
            errors.add(:base, "Must enter either description or fill template!")
        end
    end
end
