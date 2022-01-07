# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
amenities = ["In Unit Washer/Dryer", "Dishwasher", "Furnished", "Pool", "Pets Allowed", "On University Bus Route", "Parking", "Public Study Rooms", "AC", "Heating", "Gym", "Trash Chute"]
  
amenities.each do |amenity| 
    Amenity.create(amenity_name: amenity)
end