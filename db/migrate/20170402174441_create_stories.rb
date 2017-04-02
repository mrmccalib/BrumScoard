class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :description
      t.string :as
      t.string :want
      t.string :so_that
      t.string :criteria
      t.string :size
    end
  end
end
