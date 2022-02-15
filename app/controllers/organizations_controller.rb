
class OrganizationsController < ApplicationController
  def organization
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
      if !@user.is_admin
        redirect_to profile_path(id)
      end

      # ppl who are part of the org
      @members = User.where(organization_id: @user.organization_id).pluck("username")
      @org = Organization.find(@user.organization_id)
      # @bg = Organization.find(@user.organization_id).pluck("bg_color")
      # @listings = Listing.where(user_id: id)
      # # count who favorited
      # listingIDs = Listing.where(user_id: id).pluck("id")
      # @favorited_by = Favorite.where(listing_id: listingIDs).group(:listing_id).count    # number of ppl who have liked each listing


      # favoriteIDs = Favorite.where(user_id: id).pluck("listing_id")
      # @favorites = Listing.find(favoriteIDs)
    else
      redirect_to login_path
    end
  end
  
  def edit
    if session[:user_id]
      @user = User.find(session[:user_id])
      if !@user.is_admin
        redirect_to profile_path(session[:user_id])
      end
      
      @org = Organization.find(params[:id])
    else
      redirect_to login_path
    end
    
  end

  def update
    @org = Organization.find(params[:id])
    @org.update!(org_params)
    redirect_to organization_path(params[:id])
  end

  def org_params
    params.require(:organization).permit(:name, :bg_color)
  end
end
