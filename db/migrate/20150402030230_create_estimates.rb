class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.belongs_to :provider, index:true
      t.belongs_to :customer, index:true
      t.string :description
      t.string :response
      t.timestamps
    end
  end
end
