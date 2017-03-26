class CreateJoinTableBoardsUsers < ActiveRecord::Migration[5.0]
    def change
        create_join_table :boards, :users do |t|
            #   t.index [:username, :name]
            #   t.index [:name, :username]
        end
    end
end
