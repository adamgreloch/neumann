class Game < ApplicationRecord
  has_many :game_copies, class_name: "GameCopy", foreign_key: "realizes_id", dependent: :destroy
  belongs_to :owner, class_name: "User"
end
