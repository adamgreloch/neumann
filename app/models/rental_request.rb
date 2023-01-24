class RentalRequest < ApplicationRecord
  attr_accessor :wanted_games, :offered_games

  has_many :wanted_per_requests, class_name: "WantedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy
  has_many :offered_per_requests, class_name: "OfferedPerRequest",
           foreign_key: "rental_request_id", dependent: :destroy

  validates :rental_start, comparison: { less_than_or_equal_to: :rental_end }
  validates :rental_start, comparison: { greater_than_or_equal_to: DateTime.current.beginning_of_day.to_date }

  belongs_to :submitter, class_name: "User"

  scope :submitted, -> {where status: "submitted" }
  scope :archival, -> {where status: "realized" }

  after_create :assign_to_submitter
  after_update :reload_submitter

  def submitted?
    self.status == "submitted"
  end

  def open?
    self.status == "open"
  end

  def editable?
    self.status != "realized"
  end

  def can_accept?(user)
    lacks(user).count == 0
  end

  def is_submitter?(user)
    self.submitter_id == user.id
  end

  def lacks(user)
    user_has = user.available_copies.pluck(:realizes_id).uniq
    requested = wanted_per_requests.pluck(:game_id).uniq
    requested - user_has
  end

  def games_lacking(user)
    Game.find(lacks(user))
  end

  def wants?(game)
    self.wanted_per_requests.exists?(game_id: game.id)
  end

  def offers?(game)
    self.offered_per_requests.exists?(game_id: game.id)
  end

  def wanted
    Game.find(wanted_per_requests.pluck(:game_id))
  end

  def offered
    Game.find(offered_per_requests.pluck(:game_id))
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
