class AddProductsToSpreeOptionTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_option_types, :products, :string
  end
end
