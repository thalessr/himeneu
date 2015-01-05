class ChangeImageFieldName < ActiveRecord::Migration
  def change
  	rename_column :providers, :image_url, :image
  	rename_column :customers, :image_url, :image
  end
end
