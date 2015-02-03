class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
    	t.integer :cutomer_id
    	t.integer :provider_id

      t.timestamps
    end
  end
end
