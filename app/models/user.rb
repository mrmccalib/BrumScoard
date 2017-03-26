class User < ApplicationRecord
    validates :username, presence: true
    validates :username, uniqueness: { case_sensitive: false }
    validates :password, presence: true

    has_secure_password

    has_and_belongs_to_many :boards
end
