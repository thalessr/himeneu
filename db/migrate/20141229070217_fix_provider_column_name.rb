class FixProviderColumnName < ActiveRecord::Migration
  def change
  	rename_column :providers, :fist_name, :first_name
  end
end
