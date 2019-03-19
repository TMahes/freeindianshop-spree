class AddByAdminToSpreeOptionValues < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_option_values, :by_admin, :boolean,default: true
  end
end
