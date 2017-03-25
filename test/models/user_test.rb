require 'test_helper'
Rails.application.load_seed

class UserTest < ActiveSupport::TestCase
#      test "the truth" do
#        puts "Testing the truth"
#        assert true
#      end


#Tests existence of user with given username that is already in the database
    test "user existence" do
        username = "matthew"
        Testing existence of user #{username}"
        begin
            assert( User.exists?(username: username), "Error - user #{username} could not be found!")
        rescue
            puts "RESCUE: something went wrong - user with username #{username} could not be found"
            puts caller
            assert false
        end
    end


#Tests to ensure nonexistence of a user that is not in the database
    test "user nonexistence" do
        un = "1234"
        begin
            assert_not( User.exists?(username: un), "Error - user #{un} was found in database")
        rescue
            puts "Something went wrong accessing database"
            assert false
        end
    end


#Tests user creation - creates user, then checks if user exists in database
    test "user creation" do
        # puts "Testing user creation"
        begin
            User.create(:username => "testuser", :password => "pass", :first => "name", :last => "name")
            assert( User.exists?(username: 'testuser'), "Error - user with username 'testuser' does not exist!")
        rescue
            puts "something went wrong when creating the user"
            assert false
        end
        User.where(username: "testuser").destroy_all
    end

#Tests duplicate user creation - (fails to) create user with a username that already exists
    test "duplicate user creation" do
        # puts "Testing user creation"
        begin
            User.create(:username => "matthew", :password => "p455")
            puts "something went wrong - user should already exist"
            assert false
            #assert_not( User.exists?(username: 'testuser'), "Error - user with username 'testuser' does not exist!")
        rescue
          #user already exists and creation was unsuccessful
            assert true
        end
    end


end
