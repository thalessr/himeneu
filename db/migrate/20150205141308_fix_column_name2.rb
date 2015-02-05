class FixColumnName2 < ActiveRecord::Migration
	def change
		rename_column :interests, :cutomer_id, :customer_id
	end
end
