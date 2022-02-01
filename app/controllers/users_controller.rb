class UsersController < ApplicationController
  helper_method :errors_for

  def index
    # displays list of all users
  end

  def new
    # return an HTML form for creating a new user
    @user = User.new
  end

  def create
    # create a new user
    @user = User.new(user_params)

    if @user.save and (user_params[:password] == user_params[:password_confirmation])
      session[:user_id] = @user.id
      redirect_to listings_path
    else
      if user_params[:password] != user_params[:password_confirmation]
        @user.errors.add(:password_confirmation, "does not match")
        print "adding"
      end

      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    # display a user
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
      @listings = Listing.where(user_id: id)
      # count who favorited
      listingIDs = Listing.where(user_id: id).pluck("id")
      @favorited_by = Favorite.where(listing_id: listingIDs).group(:listing_id).count    # number of ppl who have liked each listing


      favoriteIDs = Favorite.where(user_id: id).pluck("listing_id")
      @favorites = Listing.find(favoriteIDs)
    else
      redirect_to login_path
    end
  end

  def edit
    # return an HTML for editing a user
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
    else
      redirect_to root_path
    end
  end

  def update
    # update a user
    # @movie = Movie.find params[:id]
    # @movie.update!(movie_params)
    # flash[:notice] = "#{@movie.title} was successfully updated."
    if session[:user_id]
      @user = User.find(session[:user_id])
      params["user"].each do |key, val|
        unless val.empty?
          @user.update_attribute(key, val)
        end
      end
      # @user.update!(user_params)
    end
    redirect_to profile_path
  end

  def destroy
    # destroy a user (deactivate)
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.destroy
      session.delete(:user_id)
      # flash[:notice] = "Movie '#{@movie.title}' deleted."
    end
    redirect_to root_path
  end

  
  # helper functions

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
