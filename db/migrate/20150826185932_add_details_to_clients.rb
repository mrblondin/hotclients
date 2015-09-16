class AddDetailsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :stage, :integer
    add_column :clients, :meeting_date, :date
    add_column :clients, :operator_status, :string
    add_column :clients, :operator_comment, :text
    add_column :clients, :partner_status, :string
    add_column :clients, :partner_comment, :text
    rename_column :clients, :birthdate, :birth_date
  end
end
