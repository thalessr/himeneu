class AddStateAndCountryToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :state, :string
    add_column :addresses, :country, :string
    add_index :addresses, :state
    add_index :addresses, :city
    add_index :addresses, :country
  end
end
