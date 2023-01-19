class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, index: true, null: false
      t.text :description

      t.integer :deposit_amount, null: false
      t.integer :deposit_paid, null: false, default: 0
      t.integer :deposit_deducted, null: false, default: 0

      t.integer :activity, default: 0

      t.timestamps
    end
  end
end
