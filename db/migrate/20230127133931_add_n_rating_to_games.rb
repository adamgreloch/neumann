class AddNRatingToGames < ActiveRecord::Migration[7.0]
  def change
    change_table :games do |t|
      t.decimal :n_rating, precision: 3, scale: 1
    end
  end
end
