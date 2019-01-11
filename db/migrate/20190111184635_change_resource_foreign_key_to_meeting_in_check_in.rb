class ChangeResourceForeignKeyToMeetingInCheckIn < ActiveRecord::Migration[5.2]
    def up
      add_column :check_ins, :meeting_id, :integer

      CheckIn.all.each do |check_in|
        if check_in.user.launches.first.resource.meetings.by_date(check_in.created_at).count == 1
          check_in.update(
            meeting_id: check_in.resource.meetings.by_date(check_in.created_at).first.id
          )
        end
      end

      remove_column :check_ins, :resource_id
    end

    def down
      add_column :check_ins, :resource_id, :integer
      CheckIn.all.each do |check_in|
          # p "hi"
          check_in.update(resource_id: check_in.user.launches.first.resource.id)
      end

      remove_column :check_ins, :meeting_id
    end
end
