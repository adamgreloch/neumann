class CreateOfferedPerRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :offered_per_requests do |t|
      t.integer :rental_request_id
      t.integer :game_id

      t.timestamps
    end

    add_index :offered_per_requests, :rental_request_id
    add_index :offered_per_requests, :game_id
    add_index :offered_per_requests, [:rental_request_id, :game_id], unique: true
  end
end
