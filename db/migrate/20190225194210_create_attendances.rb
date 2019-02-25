class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.datetime :check_in_time
      t.float :latitude
      t.float :longitude
      t.string :state, null: false
      t.references :meeting, foreign_key: true
      t.references :submission, foreign_key: true

      t.timestamps
    end

    add_index :attendances, %i[meeting_id submission_id], unique: true
  end
end
