class GameOpinion < ApplicationRecord
  belongs_to :opinion_about, class_name: 'Game', foreign_key: 'opinion_about_id'
  belongs_to :opinion_by, class_name: 'User', foreign_key: 'opinion_by_id'
  validates :max_players, comparison: { greater_than_or_equal_to: :min_players }

  after_save :update_avg

  private

  def update_avg
    # Quick average access is needed for Ransack game search.
    # Updating the average and storing it in games table is thus the least evil
    # solution, given that size of games table is unlimited.
    opinion_about.update(n_rating: opinion_about.opinions.average(:rating))
  end
end
