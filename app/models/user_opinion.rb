class UserOpinion < ApplicationRecord
  belongs_to :opinion_about, class_name: 'User', foreign_key: 'opinion_about_id'
  belongs_to :opinion_by, class_name: 'User', foreign_key: 'opinion_by_id'
end
