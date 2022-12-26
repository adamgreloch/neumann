class GameCopy < ApplicationRecord
  belongs_to :realizes, :class_name => 'Game', :foreign_key => 'realizes_id'
  belongs_to :owner, :class_name => 'Auser', :foreign_key => 'owner_id'
end
