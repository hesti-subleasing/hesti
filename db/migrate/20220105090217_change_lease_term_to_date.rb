class ChangeLeaseTermToDate < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :lease_term
    add_column :listings, :lease_start, :date
    add_column :listings, :lease_end, :date
  end
end
