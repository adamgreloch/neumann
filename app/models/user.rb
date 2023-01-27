class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :timeoutable
  before_create :set_deposit

  has_many :rental_requests, foreign_key: 'submitter_id'
  has_many :submitted_rentals, class_name: 'Rental', foreign_key: 'submitter_id'
  has_many :accepted_rentals, class_name: 'Rental', foreign_key: 'accepted_by_id'

  has_many :opinions_about, class_name: 'UserOpinion', foreign_key: 'opinion_about_id'
  has_many :opinions_by, class_name: 'UserOpinion', foreign_key: 'opinion_by_id'

  has_many :game_copies, foreign_key: 'owner_id', dependent: :destroy

  has_many :meetings_participated, class_name: 'MeetingParticipant', foreign_key: 'participant_id'
  has_many :meetings_organized, class_name: 'Meeting', foreign_key: 'organizer_id'

  has_one :open_request, -> { where status: 'open' }, class_name: 'RentalRequest', foreign_key: 'submitter_id', dependent: :destroy

  PER_GAME_ACTIVITY_BONUS = 2

  def add_activity(points)
    self.activity += points
    save
  end

  def remove_activity(points)
    if self.activity < points
      errors.add :base, 'Tried to remove more points than possible.'
    else
      self.activity -= points
      save
    end
  end

  def rentals_pending
    submitted_rentals.where(status: :accepted)
  end

  def rentals_to_swap
    accepted_rentals.or(submitted_rentals).where(status: :to_swap)
  end

  def rentals_active
    accepted_rentals.or(submitted_rentals).where(status: :swapped)
  end

  def reviewed_by?(user)
    opinions_about.where(opinion_by_id: user.id).exists?
  end

  def avg_compliance
    if opinions_about.count.zero?
      '?'
    else opinions_about.average(:compliance_rating)
    end
  end

  def avg_contact
    if opinions_about.count.zero?
      '?'
    else opinions_about.average(:contact_rating)
    end
  end

  def available_copies
    game_copies.where(rented_to_id: nil)
  end

  def find_copy_of(game_id)
    game_copies.find_by(realizes_id: game_id)
  end

  def rent_to(copy_id, user)
    game_copies.find(copy_id).update(rented_to_id: user.id)
    self.activity += PER_GAME_ACTIVITY_BONUS
    save
  end

  def retrieve_copy(copy_id)
    game_copies.find(copy_id).update(rented_to_id: nil)
    self.activity += PER_GAME_ACTIVITY_BONUS
    save
  end

  def all_rentals
    submitted_rentals + accepted_rentals
  end

  def all_active_rentals
    submitted_rentals.or(accepted_rentals).where.not(status: 'finished')
  end

  def all_archival_rentals
    submitted_rentals.or(accepted_rentals).where(status: 'finished')
  end

  def deposit_to_pay?
    !admin? && deposit_amount > deposit_paid && deposit_deducted.zero?
  end

  def admin?
    AdminEmail.where(email: email).exists?
  end

  def request_open?
    !open_request.nil?
  end

  def deposit_deducted?
    deposit_deducted.positive?
  end

  private

  def set_deposit
    self.deposit_amount = 100
    self.deposit_paid = 0
    self.deposit_deducted = 0
  end
end
