
class ListingsController < ApplicationController
  def index
    if session[:user_id]
      user = User.find(session[:user_id])
      @members = User.where(organization_id: user.organization_id)
      @listings = Listing.where(user_id: @members)
    else
      @listings = Listing.all
    end
    @amenities = Amenity.all
    @amenities_checked = get_amenities_checked
    @search = params[:query]
    
    if check_filters
      @listings = filter
    end

    @favorites = []
    if session[:user_id]
      @favorites = Favorite.where(user_id: session[:user_id]).pluck("listing_id")
    end
  end

  def new
    if session[:user_id]
      @listing = Listing.new
      @amenities = Amenity.all
    else
      redirect_to root_path
    end
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.image.attach(params[:image])
    
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

  def test
    puts "wowwww"
  end

  def show
    user = User.find(session[:user_id])
    members = User.where(organization_id: user.organization_id).pluck("id")
    @listing = Listing.find(params[:id])
    if !members.include?(@listing.user_id)
      redirect_to listings_path
    end
    @amenity_ids = AmenityMapping.joins(:amenity).where(listing_id: @listing.id).pluck("amenity_id")
    @amenities = Amenity.where(id: @amenity_ids).pluck("amenity_name")
  end

  def edit
    @listing = Listing.find(params[:id])
    @amenity_ids = AmenityMapping.joins(:amenity).where(listing_id: @listing.id).pluck("amenity_id")
    @amenities_checked = Amenity.where(id: @amenity_ids).pluck("amenity_name")
    @amenities = Amenity.all
    if @listing.user_id != session[:user_id]
      redirect_to listings_path
    end
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.user_id == session[:user_id]
      # params["listing"].each do |key, val|
      #   unless val.empty?
      #     @listing.update_attribute(key, val)
      #   end
      # end
      @listing.update!(listing_params)
      if amenity_params.has_key?("amenitymapping")
        for amenity in amenity_params["amenitymapping"]
          @amenity_mapping = AmenityMapping.create(listing_id: @listing.id, amenity_id: amenity)
        end
      end
      # @amenity_mapping = AmenityMapping.where(listing_id: @listing.id)
      # delete amenities of that listing and then add them again
      # @amenity_mapping.update(params["listing"]["amenitymapping"])
      redirect_to listing_path(@listing)
    else
      redirect_to listings_path
    end
  end

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
    return (!params[:bedroom].blank? or !params[:bathroom].blank? or !params[:amenitymapping].blank? or !params[:query].blank?)
  end

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
    listings = listings.filter_by_query(params[:query]) if params[:query].present?
    listings = listings.filter_by_amenities(amenities) if amenities.present?

    return listings
  end

  def get_amenities_checked
    return Amenity.where(id: params[:amenitymapping] ? params[:amenitymapping].select { |amenity_id| amenity_id != "0" } : []).pluck("amenity_name")
  end

  def listing_params
    list_params = params.require(:listing)
                        .permit(:title, :address_line_1, :address_line_2, :city, :state, :zip_code, :apt_complex, :rent, :lease_start, :lease_end, :private_bedroom, :private_bathroom, :num_roommates, :num_bedrooms, :num_bathrooms, :num_pets, :description, :user_id, :image)
                        .with_defaults(user_id: session[:user_id])
    return list_params
  end

  def amenity_params
    amenity_params = params.require(:listing).permit(amenitymapping: [])
  end

  def favorite
    if params[:favorite].is_a?(Array)
      if params[:favorite].length() == 2 and session[:user_id]
        @favorite = Favorite.new({user_id: session[:user_id], listing_id: params[:favorite_val]})
        if @favorite.save
          puts "savved"
        end
      elsif params[:favorite].length() == 2
        redirect_to login_path
      elsif params[:favorite].length() == 1
        Favorite.destroy_by(user_id: session[:user_id], listing_id: params[:favorite_val])
      end
    elsif params[:favorite].is_a?(String)
      if params[:favorite] == "Remove Favorite"
        Favorite.destroy_by(user_id: session[:user_id], listing_id: params[:favorite_val])
        redirect_to profile_path
      end
    end
  end
end
