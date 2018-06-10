class CreateSubAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_addresses do |t|
      t.string :sub_address
      t.integer :user_id

      t.timestamps
    end
  end
end
