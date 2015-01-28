class AddSlugToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :slug, :string
    add_index :customers, :slug, unique: true
  end
end
