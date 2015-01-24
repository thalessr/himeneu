class AddAddressIndexToCustomers < ActiveRecord::Migration
  def change
    add_index :customers, :address_id
  end
end
