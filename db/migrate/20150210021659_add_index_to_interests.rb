class AddIndexToInterests < ActiveRecord::Migration
  def change
    add_index :interests, :customer_id
    add_index :interests, :provider_id
  end
end
