class RemoveCpfFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :cpf, :string
  end
end
