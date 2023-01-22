class ExtendRentalsStatus < ActiveRecord::Migration[7.0]
  def change
    change_table :rentals do |t|
      t.string :status
    end
  end
end
