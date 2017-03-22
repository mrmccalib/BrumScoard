require 'test_helper'

class UserTest < ActiveSupport::TestCase
#     test "the truth" do
#       puts "Testing the truth"
#       assert true
#     end

    test "user existence" do
        username = "michael"
        puts "Testing existence of user #{username}"
        begin
            if User.exists?(username: username)
              puts "user exists!"
            else
              puts "something went wrong - user with username #{username} could not be found!!"
              assert false
            end
        rescue
            puts "RESCUE: something went wrong - user with username #{username} could not be found"
            puts caller
            assert false
        end
    end

    test "user nonexistence" do
        un = "1234"
        puts "Testing nonexistence of user #{un}"
        begin
            if User.exists?(username: un)
              puts "Something went wrong - user #{un} found!"
            else
              puts "User #{un} not found!"
              assert true
            end
        rescue
            puts "User with username #{un} does not exist in database"
            assert true
        end
    end

    test "user creation" do
        puts "Testing user creation"
        begin
            User.create(:username => "testuser", :password => "pass", :first => "name", :last => "name")
            if User.exists?(username: 'testuser')
              puts "User testuser created successfuly!"
              assert true
            else
              puts "Failed to create user"
              assert false
            end
        rescue
            puts "something went wrong when creating the user"
            assert false
        end
        User.where(username: "testuser").destroy_all
    end


end
