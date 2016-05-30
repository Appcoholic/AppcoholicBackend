class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.integer :product_id
      t.integer :inventory_order_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
