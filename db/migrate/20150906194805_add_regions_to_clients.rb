class AddRegionsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :city, :string
    add_column :clients, :region, :string
    add_column :clients, :city_code, :string
  end
end
