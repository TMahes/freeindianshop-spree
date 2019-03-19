class ChangeSupplierIdToBeIntegerInSpreeOptionValuess < ActiveRecord::Migration[5.1]
  def change
  	change_column :spree_option_values, :supplier_id, :string
  end
end
