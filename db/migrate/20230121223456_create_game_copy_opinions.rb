class CreateGameCopyOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :game_copy_opinions do |t|
      t.references :opinion_by, foreign_key: { to_table: :users }
      t.references :opinion_about, foreign_key: { to_table: :game_copies }
      t.integer :condition, null: false

      t.timestamps
    end
  end
end
