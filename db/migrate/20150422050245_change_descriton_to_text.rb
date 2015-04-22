class ChangeDescritonToText < ActiveRecord::Migration
  def change
    change_column :estimates, :description, :text
  end
end
