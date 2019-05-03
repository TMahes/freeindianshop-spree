class AddPickupDiscountToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :pickup_discount, :string
  end
end
