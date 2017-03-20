class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        # render plain: params[:user].inspect
        @user = User.new(user_params)
        if @user.save
            # flash.keep(:success)
            flash[:notice] = "Registration successful!"
            redirect_to login_url
        else
            render 'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :first, :last)
    end
end
