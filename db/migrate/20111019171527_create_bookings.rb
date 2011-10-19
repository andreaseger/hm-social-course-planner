class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :schedule_id
      t.integer :room_id
      t.integer :teacher_id
      t.integer :timeslot_id
      t.integer :weekday_id
      t.integer :course_id

      t.timestamps
    end
  end
end
