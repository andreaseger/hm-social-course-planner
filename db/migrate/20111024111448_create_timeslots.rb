class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.integer :start_time
      t.integer :end_time
      t.string :start_label
      t.string :end_label
      t.integer :day_id

      t.timestamps
    end

    add_index :timeslots, [:start_label, :end_label, :day_id], { unique: true }
  end
end
