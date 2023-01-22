class ChangeGameCopies < ActiveRecord::Migration[7.0]
  def change
    change_table :game_copies do |t|
      t.change :barcode, :string
    end
  end
end
