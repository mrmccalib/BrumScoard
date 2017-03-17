class User < ApplicationRecord
    validates :username, presence: true
    validates :password, presence: true
    validates :username, uniqueness: true
end
