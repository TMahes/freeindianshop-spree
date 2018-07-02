# This migration comes from spree_marketplace (originally 20150128224250)
class AddBioToSpreeSuppliers < ActiveRecord::Migration[5.1]
  def change
		add_column :spree_suppliers, :bio, :text
	end
end
