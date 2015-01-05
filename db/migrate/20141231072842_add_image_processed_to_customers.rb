class AddImageProcessedToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :image_processed, :boolean
  end
end
