class MeetingParticipant < ApplicationRecord
  belongs_to :participant, class_name: 'User', foreign_key: 'participant_id'
  belongs_to :meeting
end
