class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def show
    @user = User.find_by(params[:id])
  end

  def create
    #relative to strong parameters
    @user = User.new(user_params)
    if @user.save
      #handle a successful save
      reset_session()
      log_in(@user)
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      render(:new, {status: :unprocessable_entity})
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
