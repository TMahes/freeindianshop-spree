class RenameproductsinspreeOptionTypestoproductCategories < ActiveRecord::Migration[5.1]
  def change
  	rename_column :spree_option_types, :products, :products_category
  end
end
