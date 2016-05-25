class AddCourierIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :courier_id, :integer
  end
end
