class ChangeLeaseTermToDate < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :lease_term, :string
    add_column :listings, :lease_start, :date
    add_column :listings, :lease_end, :date
  end
end
