# This migration comes from spree_marketplace (originally 20161212220025)
class CreateSupplierToProperties < ActiveRecord::Migration[5.1]
  def change
 	create_table :spree_supplier_properties do |t|
      t.belongs_to :supplier, index: true
      t.belongs_to :property, index: true
      t.timestamps
    end

  end
end
