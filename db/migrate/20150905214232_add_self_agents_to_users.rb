class AddSelfAgentsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :partner, index: true
  end
end
