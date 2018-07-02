# This migration comes from spree_marketplace (originally 20150128193737)
class AddProfilePictureToSpreeSuppliers < ActiveRecord::Migration[5.1]
  def change
		add_attachment :spree_suppliers, :profile_picture
	end
end
