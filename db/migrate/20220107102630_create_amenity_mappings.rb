class CreateAmenityMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :amenity_mappings do |t|
      t.references :listing, null: false
      t.references :amenity, null: false

      t.timestamps
    end
    add_foreign_key :amenity_mappings, :listings
    add_foreign_key :amenity_mappings, :amenities
  end
end
