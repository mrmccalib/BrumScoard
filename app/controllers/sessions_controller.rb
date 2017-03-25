class SessionsController < ApplicationController
    def new
    end

    def create
        #   @session = Session.new(user_params)
        #   if @session.save
        #       flash[:notice] = "Registration successful!"
        #       redirect_to login_url
        #   else
        #       render 'new'
        #   end
        user = User.find_by(username: params[:session][:username].downcase)
        if params[:session][:username].empty?
            flash.now[:danger] = 'Enter username!'
            render 'new'
        elsif params[:session][:password].empty?
            flash.now[:danger] = 'Enter password!'
            render 'new'
        elsif user && user.authenticate(params[:session][:password])
            log_in user
            redirect_to signup_path
        else
            flash.now[:danger] = 'Invalid username/password combination!'
            render 'new'
        end
    end

    def directToHome
      if not params[:session][:username].empty?
        flash[:success] = 'Login successful!'
        redirect_to boards_url
      else
        flash[:danger] = 'You must log in to see this page.'
        redirect_to login_url
      end
    end


    def destroy

    end

    private

    # def user_params
    #     params.require(:user).permit(:username, :password, :first, :last)
    # end

end
