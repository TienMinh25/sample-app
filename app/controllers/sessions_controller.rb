class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        redirect_to forwarding_url || user_url(user)
      else
        # Create an error message
        message = "Account not activated. Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'sessions/new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    # status code see_other <=> 303 HTTP -> lay tai nguyen cua URI khac
    # redirect_to dung de chuyen huong
    redirect_to root_path, status: :see_other
  end

end
