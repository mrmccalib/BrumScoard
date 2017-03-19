class User < ApplicationRecord
    validates :username, presence: true
    validates :password, presence: true
    validates :username, uniqueness: true
    #
    # def validate!
    #     if username.nil?
    #         errors.add(:name, :blank, message: "Username cannot be empty!")
    #     end
    #     if password.nil?
    #         errors.add(:name, :blank, message: "Username cannot be empty!")
    #     end
    # end
end
