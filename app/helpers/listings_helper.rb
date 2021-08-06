module ListingsHelper
  def image_select(listing)
    return listing.picture if listing.picture.attached?

    # If there's no pic attached, will default to using this image. Links to show.html.erb
    return "gamecartridge.jpeg"
    
  end
end
