# This migration comes from spree_marketplace (originally 20161201193976)
class AddAgreementsToSupplier < ActiveRecord::Migration[5.1]
  def change
	add_column :spree_suppliers, :agree_tos, :boolean, default: false
	add_column :spree_suppliers, :agree_not_dropshiped, :boolean, default: false
	add_column :spree_suppliers, :agree_tos_violate, :boolean, default: false
  end
end
