class MembershipsController < ApplicationController

    def show
        @membership = current_membership
        @user = User.find(@membership.user_id)
    end

end
