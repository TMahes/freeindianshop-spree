# This migration comes from spree_fancy_menu (originally 20131029215856)
class CreateFancyMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :fancy_menu_items do |t|
      t.string :name
      t.integer :index
      t.integer :depth

      t.timestamps
    end
  end
end
