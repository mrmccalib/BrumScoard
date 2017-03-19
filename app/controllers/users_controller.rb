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
            flash[:success] = "User created successfully!"
            #TODO: redirect to login
            #redirect_to @signup
            render 'new'
        else
            render 'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :first, :last)
    end
end
