# This migration comes from spree_marketplace (originally 20130424201333)
class CreateSupplierBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_supplier_bank_accounts do |t|
      t.string :masked_number
      t.belongs_to :supplier
      t.string :token
      t.timestamps
    end
    add_index :spree_supplier_bank_accounts, :token
  end
end
