class AddMrpToSpreeVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_variants, :mrp, :string
  end
end
