class RentalRequest < ApplicationRecord
  attr_accessor :wanted_games, :offered_games
  before_create :set_status
  after_create :gather_games

  def query_wanted_games
    WantedPerRequest.includes(:game).where(rental_request_id: self.id)
  end

  def query_offered_games
    OfferedPerRequest.includes(:game).where(rental_request_id: self.id)
  end

  private

  def set_status
    self.status = "requested"
  end


  def gather_games
    # TODO rollback/transaction
    wanted_games.each do |game|
      unless game.empty?
        WantedPerRequest.create(rental_request_id: self.id, game_id: game)
      end
    end
    offered_games.each do |game|
      unless game.empty?
        OfferedPerRequest.create(rental_request_id: self.id, game_id: game)
      end
    end
  end
end
