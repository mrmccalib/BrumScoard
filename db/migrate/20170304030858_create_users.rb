class CreateUsers < ActiveRecord::Migration[5.0]
    def change
        create_table :users do |t|
            t.string :username, null: false
            t.string :first
            t.string :last
        end

        add_column :users, :password_digest, :string
    end
end
