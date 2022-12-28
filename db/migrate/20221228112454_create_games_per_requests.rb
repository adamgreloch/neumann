class CreateGamesPerRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :games_per_requests do |t|
      t.references :rental_request
      t.references :game

      t.timestamps
    end
  end
end
