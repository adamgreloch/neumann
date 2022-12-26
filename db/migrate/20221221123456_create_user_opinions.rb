class CreateUserOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_opinions do |t|
      t.references :opinion_by, foreign_key: { to_table: :users }
      t.references :opinion_about, foreign_key: { to_table: :users }
      t.integer :contact_rating, null: false
      t.integer :compliance_rating, null: false
      t.text :comment

      t.timestamps
    end
  end
end
