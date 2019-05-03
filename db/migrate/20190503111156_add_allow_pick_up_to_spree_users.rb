class AddAllowPickUpToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :allowPickUp, :boolean
  end
end
