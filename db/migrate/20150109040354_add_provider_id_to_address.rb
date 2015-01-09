class AddProviderIdToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :provider_id, :integer
    add_index  :addresses, :provider_id
  end
end
