class ChangeResourceForeignKeyToMeetingInCheckIn < ActiveRecord::Migration[5.2]
    def up
      add_reference :check_ins, :meeting, foreign_key: true

      CheckIn.find_each do |check_in|
        resource = check_in.user.launches.first.resource
        target_meeting = resource.meetings.sort_by { |meeting| (meeting.start_time.to_time - check_in.created_at).abs}.first
        check_in.update(meeting: target_meeting)
      end

      remove_column :check_ins, :resource_id
    end

    def down
      add_reference :check_ins, :resource, foreign_key: true

      CheckIn.find_each do |check_in|
          check_in.update(resource_id: check_in.user.launches.first.resource.id)
      end

      remove_column :check_ins, :meeting_id
    end
end
