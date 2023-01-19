class GameCopy < ApplicationRecord
  belongs_to :realizes, class_name: 'Game'
  belongs_to :owner, class_name: 'User'
end
