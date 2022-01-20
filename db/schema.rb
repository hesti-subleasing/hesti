# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_07_102630) do

  create_table "amenities", force: :cascade do |t|
    t.string "amenity_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "amenity_mappings", force: :cascade do |t|
    t.integer "listing_id", null: false
    t.integer "amenity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amenity_id"], name: "index_amenity_mappings_on_amenity_id"
    t.index ["listing_id"], name: "index_amenity_mappings_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "apt_complex"
    t.boolean "private_bathroom"
    t.boolean "private_bedroom"
    t.integer "num_roommates"
    t.integer "num_bedrooms"
    t.integer "num_bathrooms"
    t.integer "num_pets"
    t.text "description"
    t.string "status"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "lease_start"
    t.date "lease_end"
    t.float "rent"
    t.string "title"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.string "email"
    t.boolean "is_admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
  end

  add_foreign_key "amenity_mappings", "amenities", on_delete: :cascade
  add_foreign_key "amenity_mappings", "listings", on_delete: :cascade
  add_foreign_key "listings", "users", on_delete: :cascade
end
