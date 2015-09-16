class AddCityToCity < ActiveRecord::Migration
  def change
    rename_column :cities, :name, :city
    rename_column :cities, :code, :city_code
  end
end
