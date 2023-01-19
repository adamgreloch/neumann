class Game < ApplicationRecord
  has_many :game_copies, class_name: "GameCopy", foreign_key: "realizes_id", dependent: :destroy
  def available_copies
    self.game_copies.where(rented_to_id: nil)
  end
end
