class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.belongs_to :user

      t.timestamps
    end
    add_index :schedules, :user_id
  end
end
