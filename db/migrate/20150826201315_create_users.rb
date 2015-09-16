class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :role
      t.string :name
      t.string :surname

      t.timestamps
    end

    add_column :clients, :user_id, :integer
    add_index :clients, :user_id
  end
end
