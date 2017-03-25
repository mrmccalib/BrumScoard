class CreateBoards < ActiveRecord::Migration[5.0]
  def change

    create_table :boards, id: false do |t|
      t.string :name, null: false
      t.string :description

      #t.timestamps
    end

    execute "ALTER TABLE boards ADD PRIMARY KEY (name);"
  end
end
