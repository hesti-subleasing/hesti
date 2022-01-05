class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :apt_complex
      t.string :rent
      t.string :lease_term
      t.boolean :private_bathroom
      t.boolean :private_bedroom
      t.integer :num_roommates
      t.integer :num_bedrooms
      t.integer :num_bathrooms
      t.integer :num_pets
      t.text :description
      t.string :status
      t.references :user, null: false

      t.timestamps
    end
    add_foreign_key :listings, :users
  end
end
