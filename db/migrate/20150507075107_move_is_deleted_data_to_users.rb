class MoveIsDeletedDataToUsers < ActiveRecord::Migration
  def change
    Provider.find_each do |p|
      p.user.update_attribute(:is_deleted, p.is_deleted)
    end

    Customer.find_each do |c|
      c.user.update_attribute(:is_deleted, c.is_deleted)
    end

  end
end
