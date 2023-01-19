class Game < ApplicationRecord
  has_many :game_copies
  belongs_to :owner, class_name: "User"
end
