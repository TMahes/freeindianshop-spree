class AddPhoneToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :phone, :string
  end
end
