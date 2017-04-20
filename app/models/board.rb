class Board < ApplicationRecord

    has_many :stories, -> {order 'position asc'}

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }

    has_and_belongs_to_many :users
end
