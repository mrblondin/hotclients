class AddSnilsToClient < ActiveRecord::Migration
  def change
    add_column :clients, :snils, :string
    add_column :clients, :address, :text
  end
end
