require 'test_helper'

class UserTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    test "user existence" do
        id = 2984863745
        puts "Testing existence of user #{id}"
        begin
            user = assert User.find(id)
            puts "user exists!"
        rescue
            puts "something went wrong - user with ID #{id} could not be found"
            puts caller
            assert false
        end
    end

    test "user nonexistence" do
        puts "Testing nonexistence"
        id = 3000
        begin
            user = User.find(id)
        rescue
            puts "User with ID #{id} does not exist in database"
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
end
