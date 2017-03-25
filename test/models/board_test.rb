require 'test_helper'
Rails.application.load_seed

class BoardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "board existence" do
    boardName = "testproject"
    # Testing existence of user #{username}"
    begin
        assert( Board.exists?(name: boardName), "Error - board #{boardName} could not be found!")
    rescue
        puts "RESCUE: something went wrong with the query"
        puts caller
        assert false
    end
  end

  test "board nonexistence" do
    boardName = "vbnm"
    begin
        assert_not(Board.exists?(name: boardName), "Error - board #{boardName} was found even though it doesn't exist!")
    rescue
        puts "RESCUE: something went wrong with the query"
        puts caller
        assert false
    end
  end

  test "board creation" do
    begin
        Board.create(:name => "inserted", :description => "this is the test insertion board")
        assert( Board.exists?(name: 'inserted'), "Error - board with name 'inserted' does not exist!")
    rescue
        puts "RESCUE: something went wrong when creating the board"
        assert false
    end
    Board.where(name: "inserted").destroy_all
    #Board.where(board_name: "inserted").destroy_all
  end

  test "duplicate board creation" do
    begin
      Board.create(:name => "testproject", :description => "this should not work")
      assert false
    rescue
      #puts "board was not created because a board with that name already exists!"
      assert true
    end
  end


end
