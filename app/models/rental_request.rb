class RentalRequest < ApplicationRecord
  attr_accessor :wanted_games, :offered_games
  before_create :set_status
  has_many :wanted_per_requests, class_name: "WantedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy
  has_many :offered_per_requests, class_name: "OfferedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy

  validates :rental_start, comparison: { less_than_or_equal_to: :rental_end }

  has_one :submitter, class_name: "User", dependent: :nullify

  after_create :assign_to_submitter
  after_update :update_in_submitter

  def submitted?
    self.status != "open"
  end

  private

  def set_status
    self.status = "open"
  end

  def update_in_submitter
    if submitted?
      self.submitter.rental_request_id = null
      self.submitter.save
    end
  end

  def assign_to_submitter
    self.submitter = User.find(submitter_id)
    self.submitter.rental_request_id = self.id
    self.submitter.save
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
