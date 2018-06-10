class CreateTunes < ActiveRecord::Migration[5.1]
  def change
    create_table :tunes do |t|
      t.string :tune_name
      t.integer :tune_number
      t.integer :artist_id
      t.integer :disc_id

      t.timestamps
    end
  end
end
