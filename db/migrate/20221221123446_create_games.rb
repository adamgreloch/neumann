class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :bgg_id, null: false
      t.string :title, null: false
      t.text :description
      t.integer :release_year, null: false
      t.decimal :bgg_rating, null: false
      t.integer :bgg_rated_count, null: false
      t.integer :bgg_ranking, null: false

      t.timestamps
    end
  end
end
