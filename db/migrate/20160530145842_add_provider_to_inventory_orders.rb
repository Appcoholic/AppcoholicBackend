class AddProviderToInventoryOrders < ActiveRecord::Migration
  def change
    add_column :inventory_orders, :provider, :string
  end
end
