class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :label
      t.string :building
      t.integer :floor

      t.timestamps
    end
    add_index :rooms, :name, {unique: true}
  end
end
