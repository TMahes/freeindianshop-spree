# This migration comes from spree_marketplace (originally 20161201196976)
class CreateSpreeSupplierPrototypes < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_supplier_prototypes do |t|
      t.belongs_to :supplier, index: true
      t.belongs_to :prototype, index: true
      t.timestamps
    end
  end
end
