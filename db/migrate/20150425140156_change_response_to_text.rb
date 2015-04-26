class ChangeResponseToText < ActiveRecord::Migration
  def change
    change_column :estimates, :response, :text
  end
end
