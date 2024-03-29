class ApplicationController < ActionController::Base
  	protect_from_forgery
	
  	# all the helpers are available in the views but not in the controllers. We need the methods from the Sessions helper in both places, so we have to include it explicitly
	include SessionsHelper
end
