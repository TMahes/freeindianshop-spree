class AddSupplierIdToSpreeOptionValues < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_option_values, :supplier_id, :integer
  end
end
