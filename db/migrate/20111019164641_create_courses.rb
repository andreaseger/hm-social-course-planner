class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :label
      t.string :group

      t.timestamps
    end
    add_index :courses, :name, {unique: true}
    add_index :courses, :group
  end
end
