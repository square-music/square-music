class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.integer :total_price
      t.integer :user_id
      t.integer :status_id
      t.integer :payment_id
      t.integer :sub_address_id

      t.timestamps
    end
  end
end
