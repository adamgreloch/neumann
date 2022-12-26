class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, index: true, null: false
      t.text :description

      t.decimal :deposit_amount, null: false
      t.decimal :deposit_paid, null: false
      t.decimal :deposit_deducted, null: false

      t.integer :activity

      t.timestamps
    end
  end
end
