class Listing < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :rent, presence: true
  has_many :amenities, :through => :amenitymapping
  has_many :users, :through => :favorite

  scope :filter_by_bedroom, -> (type) { where private_bedroom: type == "Private" ? true : false }
  scope :filter_by_bathroom, -> (type) { where private_bathroom: type == "Private" ? true : false }
  scope :filter_by_query, -> (query) { where("description iLIKE ? or title iLIKE ?", "%#{query}%", "%#{query}%")}

  def self.filter_by_amenities(amenities)
    listing_ids = pluck("id")
    amenities_filtered = AmenityMapping.where(amenity_id: amenities).where(listing_id: listing_ids).group(:listing_id).count
    official = []
    amenities_filtered.each do |listing_id, count|
      if (count == amenities.count)
        official.push(listing_id)
      end
    end
    where(id: official)
  end
end
