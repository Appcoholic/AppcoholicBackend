class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_id
      t.string :address
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
