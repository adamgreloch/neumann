class RentalRequest < ApplicationRecord
  attr_accessor :wanted_games, :offered_games
  before_create :set_status
  has_many :wanted_per_requests, class_name: "WantedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy
  has_many :offered_per_requests
  validates :rental_start, comparison: { less_than_or_equal_to: :rental_end }

  # TODO gather games after submitting the request
  # after_create :gather_games
  after_create :assign_to_submitter

  def query_wanted_games
    WantedPerRequest.includes(:game).where(rental_request_id: self.id)
  end

  def query_offered_games
    OfferedPerRequest.includes(:game).where(rental_request_id: self.id)
  end

  private

  def set_status
    self.status = "open"
  end

  def assign_to_submitter
    submitter = User.find(submitter_id)
    submitter.rental_request_id = self.id
    submitter.save
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
