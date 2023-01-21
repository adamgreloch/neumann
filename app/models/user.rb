class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  before_create :set_deposit

  has_many :rental_requests, foreign_key: "submitter_id"
  has_many :submitted_rentals, class_name: "Rental", foreign_key: "submitter_id"
  has_many :accepted_rentals, class_name: "Rental", foreign_key: "accepted_by_id"

  has_many :game_copies, foreign_key: "owner_id"

  has_one :open_request, -> { where status: "open" },
          class_name: "RentalRequest", foreign_key: "submitter_id", dependent: :destroy

  def available_copies
    self.game_copies.where(rented_to_id: nil)
  end

  def find_copy_of(game_id)
    game_copies.find_by(realizes_id: game_id)
  end

  def rent_to(copy_id, user)
    game_copies.find(copy_id).update(rented_to_id: user.id)
  end

  def retrieve_copy(copy_id)
    game_copies.find(copy_id).update(rented_to_id: nil)
  end

  def all_rentals
    self.submitted_rentals + self.accepted_rentals
  end

  def all_active_rentals
    self.submitted_rentals.where.not(status: "finished") + self.accepted_rentals.where.not(status: "finished")
  end

  def all_archival_rentals
    self.submitted_rentals.where(status: "finished") + self.accepted_rentals.where(status: "finished")
  end

  def deposit_to_pay?
    self.deposit_amount > self.deposit_paid && self.deposit_deducted == 0
  end

  def is_admin?
    AdminEmail.where(email: self.email).exists?
  end

  def has_request_open?
    !self.open_request.nil?
  end

  def deposit_deducted?
    self.deposit_deducted > 0
  end

  private

  def set_deposit
    self.deposit_amount = 100
    self.deposit_paid = 0
    self.deposit_deducted = 0
  end
end
