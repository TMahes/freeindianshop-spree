class AddProductsToSpreeOptionValues < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_option_values, :products, :string
  end
end
