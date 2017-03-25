class UsersBoardsLookup < ActiveRecord::Migration[5.0]
  def change
    create_table :users_boards, :id => false do |t|
      t.belongs_to :username, index: true
      t.belongs_to :proj_name, index: true
    end
  end
end
