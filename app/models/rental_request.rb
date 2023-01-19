class RentalRequest < ApplicationRecord
  attr_accessor :wanted_games, :offered_games
  before_create :set_status
  has_many :wanted_per_requests, class_name: "WantedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy
  has_many :offered_per_requests, class_name: "OfferedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy

  validates :rental_start, comparison: { less_than_or_equal_to: :rental_end }

  belongs_to :submitter, class_name: "User"

  scope :submitted, -> {where status: "submitted" }

  after_create :assign_to_submitter
  after_update :reload_submitter

  def submitted?
    self.status != "open"
  end

  private

  def set_status
    self.status = "open"
  end

  def assign_to_submitter
    self.submitter.open_request = self
  end

  def reload_submitter
    self.submitter.reload_open_request
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
