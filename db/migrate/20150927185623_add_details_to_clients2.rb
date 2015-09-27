class AddDetailsToClients2 < ActiveRecord::Migration
  def change
    add_column :clients, :status_date, :date
    add_column :clients, :transfer_date, :date
    add_column :clients, :passport_number, :string
    add_column :clients, :passport_issued, :text
    add_column :clients, :passport_date, :date
    add_column :clients, :birth_place, :text
    add_column :clients, :sex, :string
  end
end
