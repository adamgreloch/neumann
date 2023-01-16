class OfferedPerRequest < ApplicationRecord
  belongs_to :rental_request
  belongs_to :game
  validates :rental_request_id, presence: true
  validates :game_id, presence: true
end
