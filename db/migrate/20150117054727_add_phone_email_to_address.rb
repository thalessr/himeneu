class AddPhoneEmailToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :email, :string
    add_column :addresses, :phone, :string
  end
end
