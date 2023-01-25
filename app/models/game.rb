class Game < ApplicationRecord
  has_many :game_copies, class_name: "GameCopy", foreign_key: "realizes_id", dependent: :destroy
  has_many :opinions, class_name: "GameOpinion", foreign_key: "opinion_about_id"

  def available_copies
    self.game_copies.where(rented_to_id: nil)
  end

  def n_rating
    self.opinions.average(:rating)
  end

  def n_rank
    self.opinions.where("rating <= ?", n_rating).count
  end

end
