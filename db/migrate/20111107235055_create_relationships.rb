class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :user
      t.belongs_to :classmate, class_name: "User"
      t.boolean :accepted, default: false

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :classmate_id
  end
end
