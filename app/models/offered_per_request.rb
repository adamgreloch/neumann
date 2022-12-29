class OfferedPerRequest < ApplicationRecord
  belongs_to :rental_request
  belongs_to :game
end
