class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :board_id
      t.integer :user_id
      t.string :role
    end

    add_index :memberships, [:board_id, :user_id]
  end
end
