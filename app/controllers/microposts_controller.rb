class MicropostsController < ApplicationController
  # make sure that the user is signed in before hitting any of the microposts pages
  before_filter :signed_in_user #, only: [:create, :destroy]
  # make sure that the user destroying is the owner
  before_filter :correct_user,   only: :destroy

  def create
  	@micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

private

    # find microposts only belonging to the current user
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end

end