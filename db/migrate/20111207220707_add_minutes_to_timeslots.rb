class AddMinutesToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :start_minute, :integer
    add_column :timeslots, :end_minute, :integer
  end
end
