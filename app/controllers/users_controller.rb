class UsersController < ApplicationController
  before_action(:logged_in_user, only: [:edit, :update, :index, :destroy])
  before_action(:correct_user, only:[:edit, :update])
  before_action(:admin_user, only:[:destroy])

  # show all users
  def index
    @pagy, @users = pagy(User.all(), items: 15)
  end

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

  def edit
    @user = User.find_by(params[:id])
    Rails.logger.info @user.id
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update(user_params())
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to(user_url(@user))
    else
      render('users/edit', status: :unprocessable_entity)
    end
  end

  # Delete user
  def destroy
    User.find_by(id: params[:id]).destroy()
    flash[:success] = "User deleted"
    redirect_to(users_path, status: :see_other)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location()
      flash[:danger] = "Please log in."
      redirect_to(login_url, status: :see_other)
    end
  end

  # Confirms the correct user
  def correct_user
    @user = User.find_by_id params[:id]
    if !current_user?(@user) then
      redirect_to(root_url, status: :see_other)
    end
  end

  # Confirms an admin user
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
