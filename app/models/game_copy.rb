class GameCopy < ApplicationRecord
  belongs_to :realizes, class_name: 'Game', counter_cache: true
  belongs_to :owner, class_name: 'User'
  belongs_to :rented_to, class_name: 'User', optional: true
  has_many :opinions, class_name: 'GameCopyOpinion', foreign_key: 'opinion_about_id', dependent: :destroy

  def rented?
    !rented_to.nil?
  end

  def avg_condition
    opinions.average(:condition)
  end

  def reviewed_by?(user)
    opinions.where(opinion_by: user).exists?
  end

  def review_by(user)
    opinions.find_by(opinion_by: user)
  end
end
