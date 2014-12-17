class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string	:fist_name
      t.string	:last_name
      t.integer	:age
      t.string	:image_url
      t.string	:profession
      t.text 	:experience
      t.string	:city
      t.string	:contact
      t.timestamps
    end
  end
end
