class AddLandLineToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :land_line, :string
  end
end
