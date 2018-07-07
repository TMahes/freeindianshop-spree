class AddShopNameToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :shop_name, :string
  end
end
