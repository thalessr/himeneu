class AddUserIndexToProviders < ActiveRecord::Migration
  def change
  	add_index :providers, :user_id
  end
end
