require 'test_helper'
#require "#{Rails.root}/db/seeds.rb"
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
    rescue Exception => e
        puts "TEST BOARD EXISTENCE RESCUE: something went wrong with the query"
        puts caller
        assert false
    end
  end

  test "board nonexistence" do
    boardName = "vbnm"
    begin
        assert_not(Board.exists?(name: boardName), "Error - board #{boardName} was found even though it doesn't exist!")
    rescue Exception => e
        puts "TEST BOARD NON-EXISTENCE RESCUE: something went wrong with the query"
        puts caller
        assert false
    end
  end

  test "board creation" do
    begin
        Board.create(:name => "inserted", :description => "this is the test insertion board")
        assert( Board.exists?(name: 'inserted'), "Error - board with name 'inserted' does not exist!")
    rescue Exception => e
        puts "RESCUE: something went wrong when creating the board"
        assert false
    end
    Board.where(name: "inserted").destroy_all
  end

  test "duplicate board creation" do
    begin
      Board.create(:name => "testproject", :description => "this should not work")
      assert false
    rescue Exception => e
      #puts "board was not created because a board with that name already exists!"
      assert true
    end
  end


  test "add story to board" do
    begin
        Story.create(:description => "desc1", :board_id => 1)
        assert( Story.exists?(description: 'desc1'), "Error - story with description 'desc1' does not exist!")
    rescue Exception => e
        puts "RESCUE: something went wrong creating a story"
        assert false
    end
    Story.where(description: 'desc1').destroy_all
  end


end
