class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if params[:session][:username].empty?
            flash.now[:danger] = 'Enter username!'
            render 'new'
        elsif params[:session][:password].empty?
            flash.now[:danger] = 'Enter password!'
            render 'new'
        elsif user && user.authenticate(params[:session][:password])
            log_in user
            flash[:success] = 'Login successful!'
            redirect_to boards_path
        else
            flash.now[:danger] = 'Invalid username/password combination!'
            render 'new'
        end
    end

    def destroy
      session[:user_id] = nil
      redirect_to login_url
    end
end
