class RentalRequest < ApplicationRecord
  has_many :wanted_per_requests, class_name: 'WantedPerRequest',
                                 foreign_key: 'rental_request_id', dependent: :destroy
  has_many :offered_per_requests, class_name: 'OfferedPerRequest',
                                  foreign_key: 'rental_request_id', dependent: :destroy
  has_one :realization, class_name: 'Rental', foreign_key: 'realizes_id', dependent: :destroy
  belongs_to :submitter, class_name: 'User'

  validates :rental_start, comparison: { less_than_or_equal_to: :rental_end }
  validates :rental_start, comparison: { greater_than_or_equal_to: DateTime.current.beginning_of_day.to_date }

  scope :submitted, -> { where status: 'submitted' }
  scope :archival, -> { where status: 'realized' }

  after_create :assign_to_submitter
  after_update :reload_submitter

  def empty?
    wanted_per_requests.empty? && offered_per_requests.empty?
  end

  def submitter?(user)
    !user.nil? && submitter == user
  end

  def submitted?
    status == 'submitted'
  end

  def open?
    status == 'open'
  end

  def editable?
    status != 'realized'
  end

  def can_accept?(user)
    lacks(user).count.zero?
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
    wanted_per_requests.exists?(game_id: game.id)
  end

  def offers?(game)
    offered_per_requests.exists?(game_id: game.id)
  end

  def wanted
    Game.find(wanted_per_requests.pluck(:game_id))
  end

  def offered
    Game.find(offered_per_requests.pluck(:game_id))
  end

  private

  def set_status
    self.status = 'open'
  end

  def assign_to_submitter
    submitter.open_request = self
  end

  def reload_submitter
    submitter.reload_open_request
  end
end
