class AddIsCompletedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_completed, :boolean, default: false
  end
end
