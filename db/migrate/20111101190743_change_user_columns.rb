class ChangeUserColumns < ActiveRecord::Migration
  def up
    remove_column :users, :infos
    rename_column :users, :name, :username
    add_column :users, :email, :string
  end

  def down
    add_column :users, :infos, :string
    rename_column :users, :username, :name
    remove_column :users, :email
  end
end
