class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.date :birthdate
      t.string :phone

      t.timestamps
    end
  end
end
