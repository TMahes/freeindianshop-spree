class SpreeDistance < ActiveRecord::Migration[5.1]
  def change
  	 create_table :spree_distance do |t|
      t.decimal :latitude, index: true
      t.decimal :longitude, index: true
      t.string :zipcode
    end
  end
end
