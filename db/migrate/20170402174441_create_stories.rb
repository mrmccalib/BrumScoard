class CreateStories < ActiveRecord::Migration[5.0]
    def change
        create_table :stories do |t|
            t.string  :description
            t.string  :as
            t.string  :want
            t.string  :so_that
            t.string  :criteria
            t.string  :size
            t.integer :position, index: true
            t.boolean :acceptance
            t.string  :rejection_reason
            # t.belongs_to :board, index: true
        end
        add_reference :stories, :story_column, foreign_key: true
    end
end
