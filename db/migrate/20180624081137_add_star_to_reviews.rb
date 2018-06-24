class AddStarToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :star, :integer
  end
end
