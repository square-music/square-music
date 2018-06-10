class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_phonetic
      t.text :image_id
      t.integer :product_price
      t.integer :stock
      t.text :description
      t.integer :order_item_count
      t.date :release
      t.integer :disc_amount
      t.integer :artist_id
      t.integer :label_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
