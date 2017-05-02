class UsersController < ApplicationController

    layout 'sessions'

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:username])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Registration successful!"
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
