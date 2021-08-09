class PagesController < ApplicationController
  # before_action :authenticate_user!
  def home
    @listings = Listing.all
  end
  
end
