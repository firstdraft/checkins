# frozen_string_literal: true

class AddScoreToEnrollment < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :score, :float
  end
end
