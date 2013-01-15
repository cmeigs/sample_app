class UsersController < ApplicationController
  # authorization on edit and update functionality only
  #  make sure users are signed in before continuing
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  #  make sure users are only editing/updating their own information
  before_filter :correct_user,   only: [:edit, :update]
  # restrict the destroy method to admins only
  before_filter :admin_user,     only: :destroy


  def index
    @users = User.paginate(page: params[:page])
  end


	def new
		@user = User.new
	end

  	
  def show
		@user = User.find(params[:id])  	
  end


	def create
   	@user = User.new(params[:user])
   	if @user.save
   		sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
   	else
     		render 'new'
   	end
  end


  def edit
    #@user = User.find(params[:id])   # no longer need this line because of before_filter.correct_user
  end


  def update
    #@user = User.find(params[:id])   # no longer need this line because of before_filter.correct_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  # private variables
  private

    # make sure a user is signed in, else redirect to signin page
    def signed_in_user
      unless signed_in?
        # store friendly URL so we can redirect after signin (stored in session)
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    # make sure current user is only allowed to edit their own info, else redirect to root
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    # define an admin user and check to make sure current_user is admin, else redirect to root
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end