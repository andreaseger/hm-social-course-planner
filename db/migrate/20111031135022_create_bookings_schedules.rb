class CreateBookingsSchedules < ActiveRecord::Migration
  def change
    create_table :bookings_schedules, id: false do |t|
      t.belongs_to :booking
      t.belongs_to :schedule
    end
  end
end
