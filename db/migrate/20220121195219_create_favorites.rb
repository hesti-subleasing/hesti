class CreateFavorites < ActiveRecord::Migration[6.1]
    def change
        create_table :favorites do |t|
        t.references :user, null: false
        t.references :listing, null: false

        t.timestamps
        end
        add_foreign_key :favorites, :users, on_delete: :cascade
        add_foreign_key :favorites, :listings, on_delete: :cascade
    end 
end