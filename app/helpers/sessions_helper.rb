module SessionsHelper
    def log_in(user)
        session[:username] = user.username
    end

    # Returns the current logged-in user (if any).
    def current_user
      @current_user ||= User.find_by(username: session[:username])
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
      !current_user.nil?
    end
end
