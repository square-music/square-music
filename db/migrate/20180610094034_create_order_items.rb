class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :order_item_price
      t.integer :order_quantity

      t.timestamps
    end
  end
end
