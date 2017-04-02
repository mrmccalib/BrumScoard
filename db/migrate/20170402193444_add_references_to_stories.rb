class AddReferencesToStories < ActiveRecord::Migration[5.0]
    def change
        add_reference :stories, :board, foreign_key: true
    end
end
