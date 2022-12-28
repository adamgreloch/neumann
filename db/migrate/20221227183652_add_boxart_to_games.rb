class AddBoxartToGames < ActiveRecord::Migration[7.0]
  def change
    change_table :games do |t|
      t.text :boxart_url
    end
  end
end
