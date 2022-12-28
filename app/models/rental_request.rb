class RentalRequest < ApplicationRecord
  attr_accessor :games_to_rent
  before_create :set_status, :gather_games

  private

  def set_status
    self.status = "requested"
  end

  def gather_games
    games_to_rent.each do |game_to_rent|
      if game_to_rent != ""
        GamesPerRequest.create({rental_request_id: self.id, game_id: game_to_rent})
      end
    end
  end
end
