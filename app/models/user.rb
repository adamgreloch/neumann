class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  before_create :set_deposit

  has_many :rental_requests, foreign_key: "submitter_id"
  has_one :open_request, -> { where status: "open" },
          class_name: "RentalRequest", foreign_key: "submitter_id", dependent: :destroy

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
