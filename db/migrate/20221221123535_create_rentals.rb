class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :submitter, foreign_key: { to_table: :users }
      t.references :realizes, foreign_key: { to_table: :rental_requests }
      t.string :status, null: false

      t.timestamps
    end
  end
end
