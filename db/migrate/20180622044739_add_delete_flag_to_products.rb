class AddDeleteFlagToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :delete_flag, :boolean, default: false, null: false
  end
end
