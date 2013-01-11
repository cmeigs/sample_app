module SessionsHelper

  def sign_in(user)
  	# create cookie
  	#  permanent causes Rails to set the expiration to 20.years.from_now automatically
    cookies.permanent[:remember_token] = user.remember_token

    self.current_user = user
  end

  # method to determine if user is logged in or not
  def signed_in?
    current_user.nil?
  end

  # assign user to current_user (used above)
  def current_user=(user)
    @current_user = user
  end

  # find the current user using the remember_token
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # signout user by setting current_user to null and deleting the cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

end
