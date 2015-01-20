class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.text :comment
      t.string :title
      t.integer :rating
      t.references :customer, index: true
      t.references :provider, index: true
      t.timestamps
    end
  end
end
