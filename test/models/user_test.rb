require 'test_helper'
#require "#{Rails.root}/db/seeds.rb"
Rails.application.load_seed

class UserTest < ActiveSupport::TestCase
#      test "the truth" do
#        puts "Testing the truth"
#        assert true
#      end


#Tests existence of user with given username that is already in the database
    test "user existence" do
        username = "matthew"
        #puts "Testing existence of user #{username}"
        begin
            assert( User.exists?(username: username), "Error - user #{username} could not be found!")
        rescue Exception => e
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
        rescue Exception => e
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
        rescue Exception => e
            puts "something went wrong when creating the user"
            assert false
        end
        User.where(username: "testuser").destroy_all
    end

#Tests user creation without username
    test "user creation without username" do
        # puts "Testing user creation"
        begin
            User.create(:password => "pass", :first => "name", :last => "name")
            assert false
        rescue Exception => e
            #puts caller
            assert true
        end
    end


#Tests user creation without password
    test "user creation without password" do
        # puts "Testing user creation"
        begin
            User.create(:username => "test", :first => "name", :last => "name")
            assert false
        rescue Exception => e
            assert true
        end
    end

#Tests duplicate user creation - (fails to) create user with a username that already exists
    test "duplicate user creation" do
        # puts "Testing user creation"
        username = "imax"
        begin
            User.create(:username => username, :password => "p455")
            assert false
        rescue Exception => e
          #user already exists and creation was unsuccessful
            assert true
        end
    end

end
