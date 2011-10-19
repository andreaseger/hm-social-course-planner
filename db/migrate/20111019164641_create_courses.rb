class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :label
      t.string :group

      t.timestamps
    end
  end
end
