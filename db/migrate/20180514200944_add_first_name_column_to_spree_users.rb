class AddFirstNameColumnToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :first_name, :string
  end
end
