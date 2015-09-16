class AddStatementDateToClients < ActiveRecord::Migration
  def change
    add_column :clients, :statement_date, :date
  end
end
