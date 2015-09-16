class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :region
      t.string :name
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end
end
