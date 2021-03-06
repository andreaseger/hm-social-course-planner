class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
    add_index :teachers, :name, {unique: true}
  end
end
