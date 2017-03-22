require 'test_helper'

class UserTest < ActiveSupport::TestCase
     test "the truth" do
       puts "Testing the truth"
       assert true
     end
=begin    test "user existence" do
        username = "michael"
        puts "Testing existence of user #{username}"
        begin
            if User.exists?(username: username)
              puts "user exists!"
            end
        rescue
            puts "something went wrong - user with username #{username} could not be found"
            puts caller
            assert false
        end
    end

    test "user nonexistence" do
        username = "3000"
        puts "Testing nonexistence of user #{username}"
        begin
            user = User.find(username)
            puts "Something went wrong - user found!"
        rescue
            puts "User with username #{username} does not exist in database"
            assert true
        end
    end

    test "user creation" do
        puts "Testing user creation"
        begin
            User.create(:username => "testuser", :password => "pass", :first => "name", :last => "name")
            assert User.where(username: 'testuser').take
        rescue
            puts "something went wrong when creating the user"
            assert false
        end
        User.destroy_all(username: "testuser")
    end
=end

end
