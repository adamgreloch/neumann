class CreateWantedPerRental < ActiveRecord::Migration[7.0]
  def change
    create_table :wanted_per_rentals do |t|
      t.integer :rental_id
      t.integer :game_copy_id

      t.timestamps
    end

    add_index :wanted_per_rentals, :rental_id
    add_index :wanted_per_rentals, :game_copy_id
    add_index :wanted_per_rentals, [:rental_id, :game_copy_id], unique: true
  end
end
