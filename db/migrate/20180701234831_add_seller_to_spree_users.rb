class AddSellerToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :seller, :string
  end
end
