class CreateInventoryOrders < ActiveRecord::Migration
  def change
    create_table :inventory_orders do |t|
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
