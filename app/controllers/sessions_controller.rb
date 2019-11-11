class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.password == params[:session][:password]
      log_in user
      flash.now[:primary] = 'You have been successfully logged in!'
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    flash.now[:secondary] = 'You have been successfully logged out!'
    redirect_to root_url
  end
end
