class ChangeDateTimeToDateInCustomers < ActiveRecord::Migration
  def change
  	 change_column :customers, :wedding_date, :date
  end
end
