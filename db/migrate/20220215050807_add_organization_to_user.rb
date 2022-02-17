class AddOrganizationToUser < ActiveRecord::Migration[6.1] 
  def change 
    add_reference :users, :organization, index: true
    add_foreign_key :users, :organizations, on_delete: :cascade 
  end 
end