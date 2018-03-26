class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :resource_id

      t.timestamps
    end
  end
end
