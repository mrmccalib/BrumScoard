require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "user existence" do
      puts "Test existence of user 298486374"
        begin
          user = assert User.find(298486374)
          puts "user exists!"
        rescue
          puts "something went wrong - user with ID 298486374 exists in db but assertion failed"
          assert false
        end
    end

    test "user nonexistence" do
      puts "testing nonexistence"
        begin
          user = User.find(123455667)
        rescue
          puts "User with ID 123455667 does not exist in database"
          assert true
        end
    end

end
