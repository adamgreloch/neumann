class AddCopyCountToGames < ActiveRecord::Migration[7.0]
  def change
    change_table :games do |t|
      t.integer :game_copies_count
    end
  end
end
