class AddAddressColumnToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :address, :text
  end
end
