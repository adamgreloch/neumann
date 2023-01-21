class WantedPerRental < ApplicationRecord
  belongs_to :rental
  belongs_to :game_copy
  validates :rental_id, presence: true
  validates :game_copy_id, presence: true
end
