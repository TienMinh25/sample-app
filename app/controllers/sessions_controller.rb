class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase())
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      forwarding_url = session[:forwarding_url]

      reset_session()
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in(user)
      redirect_to(forwarding_url || user_url(user))
    else
      # Create an error message
      flash.now[:danger] = 'Invalid email/password combination' # not quite right!
      render('sessions/new', status: :unprocessable_entity)

    end
  end

  def destroy
    log_out() if logged_in?()
    # status code see_other <=> 303 HTTP -> lay tai nguyen cua URI khac
    # redirect_to dung de chuyen huong
    redirect_to(root_path, status: :see_other)
  end

end
