require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  before(:all) do
    if User.where(:username => "test1").empty?
        User.create(:username => "test1", 
                    :first_name => "hi", :last_name => "hi",
                    :email => "hi@hi.hi", :password => "hi")
    end

    if Listing.where(:title => "test1").empty?
      Listing.create(:title => "test1", :address_line_1 => "hi",
                     :city => "hi", :state => "hi",
                     :zip_code => "hi", :rent => "100",
                     :user_id => 1)
    end    
  end
  
  describe "when favoriting listings" do
    it "adds a listing to favorites when signed in" do
      post :favorite, params: {:favorite => ['0', 'true'], :favorite_val => 1}, session: {user_id: 1}
      expect(Favorite.where(user_id: 1, listing_id: 1)).to exist
    end
    
    it "redirects to login when not signed in" do
      post :favorite, params: {:favorite => ['0', 'true'], :favorite_val => 1}
      expect(response).to redirect_to login_path
      expect(flash[:warning]).to match(/You must log in to favorite a listing./) 
    end

    it "removes a listing from favorites when unfavoriting" do
      Favorite.create(:user_id => 1, :listing_id => 1)
      expect(Favorite.where(user_id: 1, listing_id: 1)).to exist
      post :favorite, params: {:favorite => ['0'], :favorite_val => 1}, session: {user_id: 1}
      expect(Favorite.where(user_id: 1, listing_id: 1)).to_not exist
    end

    it "removes a listing from favorites when removing from favorites" do
      Favorite.create(:user_id => 1, :listing_id => 1)
      expect(Favorite.where(user_id: 1, listing_id: 1)).to exist
      post :favorite, params: {:favorite => "Remove Favorite", :favorite_val => 1}, session: {user_id: 1}
      expect(Favorite.where(user_id: 1, listing_id: 1)).to_not exist
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

