class AddOrderTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_total, :decimal, :precision => 9, :scale => 2
  end
end
