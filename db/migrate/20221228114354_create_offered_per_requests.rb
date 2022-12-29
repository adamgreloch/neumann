class CreateOfferedPerRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :offered_per_requests do |t|
      t.references :rental_request, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
