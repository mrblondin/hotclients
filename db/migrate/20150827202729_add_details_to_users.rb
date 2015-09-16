class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
    rename_column :users, :password, :crypted_password
    add_index :users, :email, unique: true
  end
end
