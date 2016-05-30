class RenameInventoriesTableToInventoryOrders < ActiveRecord::Migration
  def change
    rename_table :inventories, :inventory_orders
  end
end
