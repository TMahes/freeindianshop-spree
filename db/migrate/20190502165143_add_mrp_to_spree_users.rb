class AddMrpToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :mrp, :string
  end
end
