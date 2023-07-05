class AccountActivationsController < ApplicationController
  def edit_account_activation_url
    # email lay tren query parameters
    user = User.find_by email: params[:email]
    # Use params[:id] to pass in here is the same with params[:new_token] -> vi dung :id tren parameter nen dung :id de lay theo hash thoi
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attributes(activated: true, activated_at: Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user_path(user)
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
