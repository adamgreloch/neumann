class Rental < ApplicationRecord
  belongs_to :realizes, class_name: 'RentalRequest'
  belongs_to :accepted_by, class_name: 'User'
  has_many :game_copies, class_name: 'GameCopy'
  has_many :wanted_per_rentals, class_name: 'WantedPerRental', foreign_key: 'rental_id'
  has_many :offered_per_rentals, class_name: 'OfferedPerRental', foreign_key: 'rental_id'
  has_one :submitter, through: :realizes

  before_create :set_submitter_id
  after_create :realize_request

  ACCEPTED = 'accepted'.freeze
  SWAPPED = 'swapped'.freeze
  TO_SWAP = 'to_swap'.freeze
  FINISHED = 'finished'.freeze

  def to_swap?
    status == TO_SWAP
  end

  def submitter_accepted?
    submitter_status == ACCEPTED
  end

  def accept_pending?(user)
    if user == realizes.submitter
      !submitter_accepted?
    elsif user == accepted_by
      accepted_by_status != ACCEPTED
    else
      false
    end
  end

  def accept(user)
    if user == realizes.submitter
      submitter_status = ACCEPTED
    elsif user == accepted_by
      accepted_by_status = ACCEPTED
    end
    self.status = TO_SWAP if submitter_status == accepted_by_status && submitter_status == ACCEPTED
    save
  end

  def days
    (realizes.rental_end - realizes.rental_start).to_i
  end

  def days_left
    (realizes.rental_end - DateTime.current.beginning_of_day).to_i
  end

  def rental_days_left
    [days, days_left].min
  end

  def progress
    if days_left > days
      0
    else
      (days - days_left) / days
    end
  end

  def swapped?
    status == SWAPPED
  end

  def to_finish?
    status == SWAPPED
  end

  def finished?
    status == FINISHED
  end

  def swap_copies
    self.status = 'swapped'
    realizes.wanted_per_requests.each do |wanted|
      copy = accepted_by.find_copy_of(wanted.game_id)
      wanted_per_rentals.build(rental_id: id, game_copy_id: copy.id)
      accepted_by.rent_to(copy.id, realizes.submitter)
    end
    realizes.offered_per_requests.each do |offered|
      copy = submitter.find_copy_of(offered.game_id)
      offered_per_rentals.build(rental_id: id, game_copy_id: copy.id)
      submitter.rent_to(copy.id, accepted_by)
    end
    save
  end

  def swap_back_and_finish
    self.status = 'finished'

    wanted_per_rentals.each do |wanted|
      accepted_by.retrieve_copy(wanted.game_copy_id)
    end

    offered_per_rentals.each do |offered|
      submitter.retrieve_copy(offered.game_copy_id)
    end

    save
  end

  private

  def realize_request
    self.status = 'accepted'
    realizes.update(status: 'realized')
  end

  def set_submitter_id
    self.submitter_id = submitter.id
  end
end
