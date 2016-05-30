class RemoveQuantityFromInventoryOrders < ActiveRecord::Migration
  def change
    remove_column :inventory_orders, :quantity
  end
end
