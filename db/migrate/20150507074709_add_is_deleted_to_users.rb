class AddIsDeletedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_deleted, :boolean
  end
end
