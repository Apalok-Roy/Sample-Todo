module SessionsHelper
  # Logs in for a user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns logged-in user.
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url and return false
    end
    return true
  end

  # Returns true if user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns true if user is current user.
  def current_user?(user)
    user == current_user
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
