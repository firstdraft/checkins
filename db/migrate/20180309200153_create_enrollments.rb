# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments, &:timestamps
  end
end
