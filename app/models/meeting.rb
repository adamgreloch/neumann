class Meeting < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_many :meeting_participants, class_name: "MeetingParticipant", foreign_key: 'meeting_id'
  validates :date, comparison: { greater_than_or_equal_to: DateTime.current }

  def attendable?
    self.date > DateTime.current
  end

  def attends?(user)
    meeting_participants.where(participant_id: user.id).exists?
  end

  def participants
    User.where(id: meeting_participants.pluck(:participant_id))
  end

  def add_participant(user)
    self.meeting_participants.build(meeting_id: self.id, participant_id: user.id)
    self.save
  end

  def remove_participant(user)
    self.meeting_participants.find_by(participant_id: user.id).destroy
  end

end
