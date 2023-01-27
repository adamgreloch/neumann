desc 'Import games from CSV'

task import_games: :environment do
  require 'csv'

  path = "#{Rails.root}/storage/games.csv"

  CSV.foreach(path, headers: true) do |row|
    Game.create!(row.to_hash)
  end
end
