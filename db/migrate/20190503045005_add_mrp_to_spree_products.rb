class AddMrpToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :mrp, :string
  end
end
