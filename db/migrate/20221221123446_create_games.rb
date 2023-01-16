class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :bgg_id, null: false
      t.string :title, null: false

      t.integer :year_published

      t.decimal :bgg_rating, precision: 3, scale: 1
      t.integer :bgg_rating_num

      t.integer :bgg_ranking

      t.string :categories
      t.string :mechanics

      t.integer :bgg_weight

      t.integer :playing_time

      t.integer :min_players
      t.integer :max_players

      t.text :thumbnail_url
      t.text :image_url

      t.text :description

      t.string :designer
      t.string :publisher

      t.timestamps
    end
  end
end
