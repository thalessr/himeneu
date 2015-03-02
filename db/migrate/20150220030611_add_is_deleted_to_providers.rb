class AddIsDeletedToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :is_deleted, :boolean
  end
end
