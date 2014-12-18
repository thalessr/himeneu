class AddUserIndexToCustomers < ActiveRecord::Migration
  def change
  	add_index :customers, :user_id
  end
end
