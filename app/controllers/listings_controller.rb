
class ListingsController < ApplicationController
  # if there is a user, it will list all the listings associated with their organization
  def index
    if session[:user_id]
      user = User.find(session[:user_id])
      @members = User.where(organization_id: user.organization_id)
      @listings = Listing.where(user_id: @members)
    else
      @listings = Listing.all
    end

    # loading the filter/search bar
    @amenities = Amenity.all
    @amenities_checked = get_amenities_checked
    @search = params[:query]
    @min_rent = params[:min_rent]
    @max_rent = params[:max_rent]
    
    if check_filters
      @listings = filter
    end

    # marks which ones are favorited in the listings page
    @favorites = []
    if session[:user_id]
      @favorites = Favorite.where(user_id: session[:user_id]).pluck("listing_id")
    end
  end

  def new
    # loads a create new listing form
    if session[:user_id]
      @listing = Listing.new
      @amenities = Amenity.all
    else
      flash[:warning] = "You must log in to create a listing."
      redirect_to login_path
    end
  end

  # creates a new listing based on what was filled in the create new listing form
  def create
    @listing = Listing.new(listing_params)
    if params[:listing][:images].present?
      params[:listing][:images].each do |image| 
        @listing.images.attach(image)
      end
    end
    
    if @listing.save 
      if amenity_params.has_key?("amenitymapping")
        for amenity in amenity_params["amenitymapping"]
          @amenity_mapping = AmenityMapping.create(listing_id: @listing.id, amenity_id: amenity)
        end
      end
      redirect_to listing_path(@listing)
    else
      puts @listing.errors.full_messages
      @amenities = Amenity.all
      render :new, status: :unprocessable_entity
    end
  end

  # shows a listing
  def show
    user = User.find(session[:user_id])
    members = User.where(organization_id: user.organization_id).pluck("id")
    @listing = Listing.find(params[:id])
    @listing = Listing.with_attached_images.find(params[:id])

    # checks to see if it has been requested by a user, if it has then it'll show different buttons on the page
    requested_listing = Request.where(user_id: session[:user_id], listing_id: params[:id])
    if requested_listing.blank?
      @requested = false
    else
      @requested = true
    end
    if !members.include?(@listing.user_id)
      redirect_to listings_path
    end

    # shows the amenities for each listing
    @amenity_ids = AmenityMapping.joins(:amenity).where(listing_id: @listing.id).pluck("amenity_id")
    @amenities = Amenity.where(id: @amenity_ids).pluck("amenity_name")
  end

  def edit
    # shows the edit page of a certain listing
    @listing = Listing.find(params[:id])

    # marks the amenities that were marked originally
    @amenity_ids = AmenityMapping.joins(:amenity).where(listing_id: @listing.id).pluck("amenity_id")
    @amenities_checked = Amenity.where(id: @amenity_ids).pluck("amenity_name")
    @amenities = Amenity.all

    # checks to make sure that the session's user is the one who owns the listing
    if @listing.user_id != session[:user_id]
      redirect_to listings_path
    end
  end

  # updates the listing based on edit form
  def update
    @listing = Listing.find(params[:id])
    if @listing.user_id == session[:user_id]
      @listing.update!(listing_params)

      if listing_params[:images].present?
        listing_params[:images].each do |image|
          @listing.images.attach(image)
        end
      end
      if amenity_params.has_key?("amenitymapping")
        for amenity in amenity_params["amenitymapping"]
          @amenity_mapping = AmenityMapping.create(listing_id: @listing.id, amenity_id: amenity)
        end
      end
      redirect_to listing_path(@listing)
    else
      redirect_to listings_path
    end
  end

  # deletes listing from database
  def destroy
    @listing = Listing.find(params[:id])
    if @listing.user_id == session[:user_id]
      @listing.destroy
      redirect_to profile_path
    else
      redirect_to listings_path
    end
  end

  def check_filters
    return (!params[:bedroom].blank? or !params[:bathroom].blank? or !params[:amenitymapping].blank? or !params[:query].blank? or !params[:min_rent].blank? or !params[:max_rent].blank?)
  end

  # returns listings based on filters from user
  def filter
    if session[:user_id]
      user = User.find(session[:user_id])
      @members = User.where(organization_id: user.organization_id)
      listings = Listing.where(user_id: @members)
    else
      listings = Listing.all
    end
    
    amenities = params[:amenitymapping] ? params[:amenitymapping].select { |amenity_id| amenity_id != "0" } : []

    listings = listings.filter_by_bedroom(params[:bedroom]) if params[:bedroom].present?
    listings = listings.filter_by_bathroom(params[:bathroom]) if params[:bathroom].present?
    listings = listings.filter_by_min_rent(params[:min_rent]) if params[:min_rent].present?
    listings = listings.filter_by_max_rent(params[:max_rent]) if params[:max_rent].present?
    listings = listings.filter_by_query(params[:query]) if params[:query].present?
    listings = listings.filter_by_amenities(amenities) if amenities.present?

    return listings
  end

  def get_amenities_checked
    return Amenity.where(id: params[:amenitymapping] ? params[:amenitymapping].select { |amenity_id| amenity_id != "0" } : []).pluck("amenity_name")
  end

  def listing_params
    list_params = params.require(:listing)
                        .permit(:title, :address_line_1, :address_line_2, :city, :state, :zip_code, :apt_complex, :rent, :lease_start, :lease_end, :private_bedroom, :private_bathroom, :num_roommates, :num_bedrooms, :num_bathrooms, :num_pets, :description, :user_id)
                        .with_defaults(user_id: session[:user_id])
    return list_params
  end

  def amenity_params
    amenity_params = params.require(:listing).permit(amenitymapping: [])
  end

  # creates a new favorite record every time a user favorites a listing
  def favorite
    # if favorites is an array of length 2, add to favorites table
    # if favorites is an array of length 1 or just a string, remove from favorites table
    # this is because every time it's clicked a hidden form field gets passed too saying that it was favorited
    if params[:favorite].is_a?(Array)
      if params[:favorite].length() == 2 and session[:user_id]
        @favorite = Favorite.new({user_id: session[:user_id], listing_id: params[:favorite_val]})
        if @favorite.save
        end
      elsif params[:favorite].length() == 2
        flash[:warning] = "You must log in to favorite a listing."
        redirect_to login_path
      elsif params[:favorite].length() == 1
        Favorite.destroy_by(user_id: session[:user_id], listing_id: params[:favorite_val])
      end
    elsif params[:favorite].is_a?(String)
      if params[:favorite].downcase == "remove favorite"
        Favorite.destroy_by(user_id: session[:user_id], listing_id: params[:favorite_val])
        redirect_to profile_path
      end
    end
  end

  # adds a request record when a user requests for a listing
  def request_listing
    @requested_listing = Request.new({user_id: session[:user_id], listing_id: params[:requested_listing]})
    if @requested_listing.save
      puts "saved"
    end  
    redirect_back(fallback_location: root_path)
  end
  
  # removes request record when user cancels request
  def cancel_request
    Request.destroy_by(user_id: session[:user_id], listing_id: params[:requested_listing])
    redirect_back(fallback_location: root_path)
    # redirect_to listing_path(params[:requested_listing])
  end

  # lets user who owns a listing view other users who requested their listing
  def pending_requests
    listing = Listing.find(params[:id])
    # makes sure that the user accessing the page owns the listing
    if session[:user_id] == listing.user_id
      # requests returns an array of [request_ids, username, emails of requesters]
      @requests = Request.where(listing_id: params[:id]).joins(:user).pluck("id", "username", "email")
    else
      redirect_to profile_path
    end
  end
end
