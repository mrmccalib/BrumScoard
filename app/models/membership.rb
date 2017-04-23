class Membership < ApplicationRecord
    belongs_to :board
    belongs_to :user

    enum role: [:developer, :product_owner]

end
