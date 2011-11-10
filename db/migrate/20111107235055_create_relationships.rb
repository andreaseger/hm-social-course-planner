class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :user
      t.belongs_to :classmate, class_name: "User"

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :classmate_id
    add_index :relationships, [:user_id, :classmate_id], { unique: true }
  end
end
