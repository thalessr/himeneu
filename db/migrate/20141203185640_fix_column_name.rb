class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :customers, :fist_name, :first_name
  end
end
