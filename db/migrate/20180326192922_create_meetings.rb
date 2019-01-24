# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :resource_id

      t.timestamps
    end
  end
end
