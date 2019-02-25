class ChangeStateToStatusOnAttendance < ActiveRecord::Migration[5.2]
  def change
    rename_column :attendances, :state, :status
  end
end
