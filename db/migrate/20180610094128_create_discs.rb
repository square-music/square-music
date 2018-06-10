class CreateDiscs < ActiveRecord::Migration[5.1]
  def change
    create_table :discs do |t|
      t.integer :disc_number
      t.integer :product_id

      t.timestamps
    end
  end
end
