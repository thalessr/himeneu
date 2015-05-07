class RemoveIsDeletedColumnFromProvidersAndCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :is_deleted, :boolean
    remove_column :providers, :is_deleted, :boolean
  end
end
