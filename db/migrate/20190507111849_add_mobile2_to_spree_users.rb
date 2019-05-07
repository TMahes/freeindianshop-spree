class AddMobile2ToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :mobile2, :string
  end
end
