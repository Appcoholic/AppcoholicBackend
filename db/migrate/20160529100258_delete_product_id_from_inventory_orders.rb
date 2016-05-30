class DeleteProductIdFromInventoryOrders < ActiveRecord::Migration
  def change
    remove_column :inventory_orders, :product_id
  end
end
