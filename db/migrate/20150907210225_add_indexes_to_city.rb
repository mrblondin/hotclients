class AddIndexesToCity < ActiveRecord::Migration
  def change
    change_column :cities, :city_code, :string, :limit => 13
    change_column :clients, :city_code, :string, :limit => 13
    add_index :cities, :city_code, unique: false
    add_index :clients, :city_code, unique: false
  end
end
