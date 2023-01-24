class GameOpinion < ApplicationRecord
  belongs_to :opinion_about, class_name: 'Game', foreign_key: 'opinion_about_id'
  belongs_to :opinion_by, class_name: 'User', foreign_key: 'opinion_by_id'
  validates :max_players, comparison: { greater_than_or_equal_to: :min_players }
end
