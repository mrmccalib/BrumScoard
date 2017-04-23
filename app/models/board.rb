class Board < ApplicationRecord

    has_many :stories, -> {order 'position asc'}

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }

    # has_and_belongs_to_many :users
    has_many :memberships
    has_many :invitations
    has_many :users, through: :memberships
    has_many :users, through: :invitations
end
