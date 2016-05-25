class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :token
      t.integer :status, default: 0
      t.string :address
      t.text :comments

      t.timestamps null: false
    end
  end
end
