class ChangeImageProcessedToProcessing < ActiveRecord::Migration
  def change
  	add_column :providers, :image_processing, :boolean, null: false, default: false
  	add_column :customers, :image_processing, :boolean, null: false, default: false
  	remove_column :customers, :image_processed, :boolean
  end
end
