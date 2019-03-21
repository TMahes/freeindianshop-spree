class AddSellerSkuToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :seller_sku, :string
  end
end
