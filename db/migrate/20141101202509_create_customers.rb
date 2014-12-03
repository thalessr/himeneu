class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cpf
      t.string :fist_name
      t.string :last_name
      t.integer :age
      t.string :image_url
      t.datetime :wedding_date

      t.timestamps
    end
  end
end
