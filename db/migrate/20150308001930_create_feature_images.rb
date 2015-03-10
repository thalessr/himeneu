class CreateFeatureImages < ActiveRecord::Migration
  def change
    create_table :feature_images do |t|
      t.string :image
      t.belongs_to :provider, index:true

      t.timestamps
    end
  end
end
