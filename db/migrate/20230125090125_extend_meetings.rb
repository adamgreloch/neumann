class ExtendMeetings < ActiveRecord::Migration[7.0]
  def change
    change_table :meetings do |t|
      t.references :organizer, foreign_key: { to_table: :users }, index: true

      t.string :title, null: false
      t.string :location, null: false
      t.time :time, null: false
      t.date :date, null: false
      t.text :description
    end
  end
end
