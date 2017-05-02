class CreateBoards < ActiveRecord::Migration[5.0]
    def change
        create_table :boards do |t|
            t.string :name, null: false
            t.string :description
        end

        create_table :sprints do |t|
            t.integer  :number
            t.datetime :created_at
        end

        create_table :story_columns do |t|
            t.string :name, null: false
            t.integer :position, index: true
        end

        create_table :task_columns do |t|
            t.string :name, null: false
            t.integer :position, index: true
        end

        add_reference :sprints,       :board,  foreign_key: true
        add_reference :story_columns, :sprint, foreign_key: true
        add_reference :task_columns,  :sprint, foreign_key: true


         add_index :sprints, :created_at
    end
end
