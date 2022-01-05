class ChangeRentToFloat < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :rent
    add_column :listings, :rent, :float
  end
end
