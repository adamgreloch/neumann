class CreateGameCopies < ActiveRecord::Migration[7.0]
  def change
    create_table :game_copies do |t|
      t.references :realizes, foreign_key: { to_table: :games }
      t.references :owner, foreign_key: { to_table: :users }
      t.references :rented_to, foreign_key: { to_table: :users }
      t.integer :condition, null: false
      t.integer :barcode, null: false
      t.text :description

      t.timestamps
    end
  end
end
