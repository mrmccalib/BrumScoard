class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :board_id
      t.integer :user_id
      t.integer :role
    end

    add_index :invitations, [:board_id, :user_id]
  end
end
