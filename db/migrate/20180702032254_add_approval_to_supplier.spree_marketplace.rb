# This migration comes from spree_marketplace (originally 20161201193956)
class AddApprovalToSupplier < ActiveRecord::Migration[5.1]
  def change
	add_column :spree_suppliers, :approved, :boolean, default: false
  end
end
