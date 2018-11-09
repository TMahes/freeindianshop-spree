class AddProductVariantDescToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :product_variant_desc, :string
  end
end
