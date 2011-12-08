class AddHoursToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :start_hour, :integer
    add_column :timeslots, :end_hour, :integer
  end
end
