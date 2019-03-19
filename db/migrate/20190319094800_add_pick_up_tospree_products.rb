class AddPickUpTospreeProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :spree_products, :pick_up, :boolean,default: false
  end
end
