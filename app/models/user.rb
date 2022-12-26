class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :set_deposit

  def set_deposit
    self.deposit_amount = 100
    self.deposit_deducted = 0
    self.deposit_paid = 0
  end
end
