class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
    add_index :courses, :name, {unique: true}
  end
end
