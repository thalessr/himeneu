class AddStatetoInterest < ActiveRecord::Migration
  def change
    add_column :interests, :state, :string
  end
end
