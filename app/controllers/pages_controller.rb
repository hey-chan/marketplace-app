class PagesController < ApplicationController
  # before_action :authenticate_user!
  def home
    @q = Listing.ransack(params[:q])
    @listings = @q.result

    # @listings = Listing.all
  end
  
end
