class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false
      t.references :listing, null: false

      t.timestamps
    end
    add_foreign_key :requests, :users, on_delete: :cascade
    add_foreign_key :requests, :listings, on_delete: :cascade
  end
end
