class AddMadeInIndiaToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :MadeInIndia, :boolean
  end
end
