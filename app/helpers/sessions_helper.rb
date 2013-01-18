module SessionsHelper

  def sign_in(user)
  	# create cookie
  	#  permanent causes Rails to set the expiration to 20.years.from_now automatically
    cookies.permanent[:remember_token] = user.remember_token

    # create variable current_user, accessible in both controllers and views
    self.current_user = user
  end

  # method to determine if user is logged in or not
  def signed_in?
    !current_user.nil?
  end

  # assign user to current_user (used above)
  #  this = in the method name is designed to handle assignment to current_user 
  #  so when we have an assignment like this: (self.current_user = ...), this method will be called
  def current_user=(user)
    @current_user = user
  end

  # find the current user using the remember_token
  #  this method is designed to return the value of @current_user
  def current_user
    # ||= (“or equals”) will populate @current_user but only if it is undefined
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    # in this case, find_by_remember_token will be called at least once every time a user visits a page on the site but will know @current_user after it is populated
  end

  # define bool current_user variable
  def current_user?(user)
    user == current_user
  end

  # make sure a user is signed in, else redirect to signin page
  def signed_in_user
    unless signed_in?
      # store friendly URL so we can redirect after signin (stored in session)
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end


  # signout user by setting current_user to null and deleting the cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # recall the location of the URL we are trying to get to OR direct to default
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # store the location of the URL we are trying to get to
  def store_location
    session[:return_to] = request.url
  end
end
