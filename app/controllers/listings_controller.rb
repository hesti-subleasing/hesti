
class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to listing_path(@listing)
    else
      puts @listing.errors.full_messages
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
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

  def listing_params
    list_params = params.require(:listing)
                        .permit(:title, :address_line_1, :address_line_2, :city, :state, :zip_code, :apt_complex, :rent, :lease_start, :lease_end, :private_bedroom, :private_bathroom, :num_roommates, :num_bedrooms, :num_bathrooms, :num_pets, :description, :user_id)
                        .with_defaults(user_id: session[:user_id])
    return list_params
  end
end
