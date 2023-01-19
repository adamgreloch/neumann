class Rental < ApplicationRecord
  belongs_to :realizes, class_name: 'RentalRequest'
  belongs_to :accepted_by, class_name: 'User'
  has_many :game_copies, class_name: 'GameCopy'
end
