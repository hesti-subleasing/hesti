require 'rails_helper'

RSpec.describe Listing, type: :model do
  before(:all) do
    if User.where(:username => "test1").empty?
        User.create(:username => "test1", 
                    :first_name => "hi", :last_name => "hi",
                    :email => "hi@hi.hi", :password => "hi")
    end

    if Amenity.where(:amenity_name => "Dishwasher").empty?
        Amenity.create(:amenity_name => "Dishwasher")
        Amenity.create(:amenity_name => "Furnished")
    end

    if Listing.where(:title => "test1").empty?
        Listing.create(:title => "test1", :address_line_1 => "hi",
                       :city => "hi", :state => "hi",
                       :zip_code => "hi", :rent => "100",
                       :user_id => 1)
        Listing.create(:title => "test2", :address_line_1 => "hi",
          :city => "hi", :state => "hi",
          :zip_code => "hi", :rent => "100",
          :user_id => 1)
    end

    if AmenityMapping.where(:id => 1).empty?
        AmenityMapping.create(:listing_id => 1, :amenity_id => 1)
        AmenityMapping.create(:listing_id => 1, :amenity_id => 2)
        AmenityMapping.create(:listing_id => 2, :amenity_id => 2)
    end
  end
  
  describe "filter_by_amenities method" do
    it "should filter 1 listing with 1 amenity" do
      expect(Listing.filter_by_amenities([1])).to include(Listing.find_by_title("test1"))
      expect(Listing.filter_by_amenities([1])).to_not include(Listing.find_by_title("test2"))
    end

    it "should filter 2 listings with 1 amenity" do
      expect(Listing.filter_by_amenities([2])).to include(Listing.find_by_title("test1"))
      expect(Listing.filter_by_amenities([2])).to include(Listing.find_by_title("test2"))
    end

    it "should filter 1 listing with multiple amenities" do
      expect(Listing.filter_by_amenities([1,2])).to include(Listing.find_by_title("test1"))
      expect(Listing.filter_by_amenities([1,2])).to_not include(Listing.find_by_title("test2"))
    end
  end
end


