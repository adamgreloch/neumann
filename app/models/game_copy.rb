class GameCopy < ApplicationRecord
  belongs_to :realizes, class_name: 'Game'
  belongs_to :owner, class_name: 'User'
  belongs_to :rented_to, class_name: 'User', optional: true
  has_many :opinions, class_name: "GameCopyOpinion", foreign_key: "opinion_about_id"

  def rented?
    !self.rented_to.nil?
  end

  def avg_condition
    self.opinions.average(:condition)
  end
end
