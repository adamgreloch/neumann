class CreateMeetingParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_participants do |t|
      t.integer :meeting_id
      t.integer :participant_id

      t.timestamps
    end

    add_index :meeting_participants, :meeting_id
    add_index :meeting_participants, :participant_id
    add_index :meeting_participants, [:meeting_id, :participant_id], unique: true
  end
end
