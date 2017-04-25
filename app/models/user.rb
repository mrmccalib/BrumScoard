class User < ApplicationRecord

    has_many :tasks

    validates :username, presence: true
    validates :username, uniqueness: { case_sensitive: false }
    validates :password, presence: true

    has_secure_password

    # has_and_belongs_to_many :boards
    has_many :memberships
    has_many :invitations
    has_many :boards, through: :memberships
    has_many :boards, through: :invitations

end
