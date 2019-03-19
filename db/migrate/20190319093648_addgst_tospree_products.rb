class AddgstTospreeProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_products, :gst, :string
  end
end
