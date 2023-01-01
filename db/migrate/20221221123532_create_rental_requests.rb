class CreateRentalRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_requests do |t|
      t.references :submitter, foreign_key: { to_table: :users }
      t.string :status, null: false
      t.date :rental_start, null: false
      t.date :rental_end, null: false

      t.timestamps
    end
  end
end
