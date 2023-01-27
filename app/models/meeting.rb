class Meeting < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_many :meeting_participants, class_name: 'MeetingParticipant', foreign_key: 'meeting_id'
  validates :date, comparison: { greater_than_or_equal_to: DateTime.current }
  after_create :add_organizer_activity
  after_destroy :remove_organizer_activity

  ORGANIZE_MEETING_BONUS = 10

  def current?
    date > DateTime.current
  end

  def attends?(user)
    meeting_participants.where(participant_id: user.id).exists?
  end

  def participants
    User.where(id: meeting_participants.pluck(:participant_id))
  end

  def add_participant(user)
    meeting_participants.build(meeting_id: id, participant_id: user.id)
    save
  end

  def remove_participant(user)
    meeting_participants.find_by(participant_id: user.id).destroy
  end

  private

  def add_organizer_activity
    organizer.add_activity(ORGANIZE_MEETING_BONUS)
  end

  def remove_organizer_activity
    organizer.remove_activity(ORGANIZE_MEETING_BONUS)
  end
end
