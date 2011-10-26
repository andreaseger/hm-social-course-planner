class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :course
      t.belongs_to :timeslot
      t.belongs_to :room
      t.belongs_to :group
      t.string :suffix

      t.timestamps
    end

    add_index :bookings, :course_id
    add_index :bookings, :timeslot_id
    add_index :bookings, :room_id
    add_index :bookings, :group_id
  end
end
