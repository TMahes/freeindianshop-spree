class AddColumnsToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :dob, :string
    add_column :spree_users, :city, :string
    add_column :spree_users, :state, :string
    add_column :spree_users, :zip_code, :string
  end
end
