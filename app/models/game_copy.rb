class GameCopy < ApplicationRecord
  belongs_to :realizes, class_name: 'Game'
  belongs_to :owner, class_name: 'User'
  belongs_to :rented_to, class_name: 'User', optional: true

  def rented?
    !self.rented_to.nil?
  end
end
