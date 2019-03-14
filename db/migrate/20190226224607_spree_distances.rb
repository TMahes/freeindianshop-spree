class SpreeDistances < ActiveRecord::Migration[5.1]
  def change
  	 create_table :spree_distances do |t|
      t.decimal :latitude, index: true
      t.decimal :longitude, index: true
      t.string :zipcode
    end
  end
end
