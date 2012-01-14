class AddObsoleteToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :obsolete, :boolean
  end
end
