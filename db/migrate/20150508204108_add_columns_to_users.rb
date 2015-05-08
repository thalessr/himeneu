class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_provider, :string
    add_column :users, :uid, :string
  end
end
