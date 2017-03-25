require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end


  test "board existence" do
    boardName = "testproject"
    # Testing existence of user #{username}"
    begin
        assert( Board.exists?(name: boardName), "Error - board #{boardName} could not be found!")
    rescue
        puts "RESCUE: something went wrong - board with name #{boardName} could not be found"
        puts caller
        assert false
    end
  end
end
