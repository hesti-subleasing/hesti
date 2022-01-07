class Amenity < ApplicationRecord
    has_many :listings, :through => :amenitymapping
end
