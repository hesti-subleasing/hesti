class ChangeRentToFloat < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :rent, :string
    add_column :listings, :rent, :float
  end
end
