class AddTokenToInventoryOrders < ActiveRecord::Migration
  def change
    add_column :inventory_orders, :token, :string
  end
end
