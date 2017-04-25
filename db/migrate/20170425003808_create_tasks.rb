class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :weight

    end
    add_reference :tasks, :story, foreign_key: true
    add_reference :tasks, :user, foreign_key: true
  end
end
