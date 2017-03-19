class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    #drop_table :users
    create_table :users, id: false do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :first
      t.string :last

    end
    execute "ALTER TABLE users ADD PRIMARY KEY (username);"
  end
end
