class Board < ApplicationRecord

    # has_many :story_columns
    # has_many :task_columns
    has_many :sprints

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }

    has_many :memberships
    has_many :invitations
    has_many :users, through: :memberships
    has_many :users, through: :invitations

end
