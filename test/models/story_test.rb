require 'test_helper'

class StoryTest < ActiveSupport::TestCase


  # test "the truth" do
  #     assert true
  # end

#Tests if story doesn't exist
  test "Story Non-existence" do
     desc = "adsf"
     begin
       assert_not(Story.exists?(description: desc), "Error - story with description #{desc} could not be found!")
     rescue Exception => e
       puts "RESCUE: error accessing database"
       assert false
     end
  end

#Tests that story does exist
  test "Story Existence" do
     desc = "firstStory"
     begin
       assert(Story.exists?(description: desc), "Error - story with description #{desc} could not be found!")
     rescue Exception => e
       puts "RESCUE: error accessing database"
       assert false
     end
  end

#Tests that story was created
  test "Story creation" do
    begin
      Story.create(:description => "testStory", :as => "testPerson", :want => "testWant", :so_that => "testSoThat",
                   :criteria => "testCriteria", :size => "testSize")
      assert( Story.exists?(description: 'testStory'), "Error - story with description 'testStory' does not exist! " )
    rescue Exception => e
      puts "RESCUE: something went wrong creating the Story."
      assert false
    end
    Story.where(description: "testStory").destroy_all
  end

#Tests story creation without a description
  test "Story creation without description or template" do
    begin
      Story.create(:criteria => "testCriteria", :size => "testSize")
      assert false
    rescue Exception => e
      assert true
    end
  end


end
