class AddIndexNameAndEmailToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_index :customers, :name, unique: true
    add_index :customers, :email, unique: true
  end
end
