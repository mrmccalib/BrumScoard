class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    #drop_table :users
    create_table :users, id: false do |t|
      t.string :username, null: false
    #   t.string :password, null: false
    #   t.string :password_digest
      t.string :first
      t.string :last
    end

    add_column :users, :password_digest, :string
    execute "ALTER TABLE users ADD PRIMARY KEY (username);"
  end
end
