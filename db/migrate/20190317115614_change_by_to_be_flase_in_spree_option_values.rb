class ChangeByToBeFlaseInSpreeOptionValues < ActiveRecord::Migration[5.1]
  def change
  	change_column :spree_option_values, :by_admin, :boolean, :default => false
  end
end
