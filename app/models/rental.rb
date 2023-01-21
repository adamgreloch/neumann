class Rental < ApplicationRecord
  belongs_to :realizes, class_name: 'RentalRequest'
  belongs_to :accepted_by, class_name: 'User'
  has_many :game_copies, class_name: 'GameCopy'
  has_many :wanted_per_rentals, class_name: 'WantedPerRental', foreign_key: "rental_id"
  has_many :offered_per_rentals, class_name: 'OfferedPerRental', foreign_key: "rental_id"
  has_one :submitter, through: :realizes

  before_create :set_submitter_id
  after_create :realize_request

  def to_swap?
    self.status == "accepted"
  end

  def swapped?
    self.status == "swapped"
  end

  def to_finish?
    self.status == "swapped"
  end

  def finished?
    self.status == "finished"
  end

  def swap_copies
    self.status = "swapped"
    self.realizes.wanted_per_requests.each do |wanted|
      copy = accepted_by.find_copy_of(wanted.game_id)
      wanted_per_rentals.build(rental_id: self.id, game_copy_id: copy.id)
      accepted_by.rent_to(copy.id, realizes.submitter)
    end
    self.realizes.offered_per_requests.each do |offered|
      copy = submitter.find_copy_of(offered.game_id)
      offered_per_rentals.build(rental_id: self.id, game_copy_id: copy.id)
      submitter.rent_to(copy.id, accepted_by)
    end
    self.save
  end

  private
  def realize_request
    self.status = "accepted"
    self.realizes.update(status: "realized")
  end

  def set_submitter_id
    self.submitter_id = submitter.id
  end
end
