class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if params[:user][:password] == params[:user][:password_confirmation]
      if @user.save
        log_in @user
        flash[:success] = "Congratulation, your profile is created Sucessfully!"
        redirect_to root_url
      else
        render 'new'
      end
    else
      flash[:error] = "Password didn't matched!"
      render 'new'
    end
  end

  private
  # Permiseble parameters.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Authenticates correct user.
  def authenticate_user
    if logged_in_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
  end
end
