class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :set_deposit

  def deposit_to_pay?
    self.deposit_amount > self.deposit_paid && self.deposit_deducted == 0
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
