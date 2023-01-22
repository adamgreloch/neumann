class ChangeRentals < ActiveRecord::Migration[7.0]
  def change
    change_table :rentals do |t|
      t.rename :status, :accepted_by_status
      t.string :submitter_status
    end
  end
end
