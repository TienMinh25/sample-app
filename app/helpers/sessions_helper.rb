module SessionsHelper
  # Log in the given user
  def log_in(user)
    session[:user_id] = user.id

    # Guard against session replay attacks
    session[:session_token] = user.session_token
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # returns the current logged_in user (if any)
  def current_user
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  
  # return true if the given user is the current user.
  def current_user?(user)
    user && user == current_user()
  end

  # Return true if the user is logged in, false otherwise
  def logged_in?
    return !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  # Forgets a persistent session
  def log_out
    forget current_user()
    reset_session
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
