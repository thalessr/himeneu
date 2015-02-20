class AddIsDeletedToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :is_deleted, :boolean
  end
end
