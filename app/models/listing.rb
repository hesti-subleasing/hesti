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
end
