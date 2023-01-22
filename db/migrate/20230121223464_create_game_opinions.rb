class CreateGameOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :game_opinions do |t|
      t.references :opinion_by, foreign_key: { to_table: :users }
      t.references :opinion_about, foreign_key: { to_table: :games }

      t.integer :rating, null: false
      t.integer :weight, null: false

      t.integer :playing_time, null: false

      t.integer :min_players, null: false
      t.integer :max_players, null: false

      t.text :comment

      t.timestamps
    end
  end
end
