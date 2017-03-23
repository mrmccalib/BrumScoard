class User < ApplicationRecord
    validates :username, presence: true
    validates :username, uniqueness: { case_sensitive: false }

    has_secure_password

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
