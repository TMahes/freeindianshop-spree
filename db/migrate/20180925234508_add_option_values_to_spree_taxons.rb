class AddOptionValuesToSpreeTaxons < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :option_values, :string
  end
end
