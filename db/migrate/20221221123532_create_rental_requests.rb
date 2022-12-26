class CreateRentalRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_requests do |t|

      t.timestamps
    end
  end
end
