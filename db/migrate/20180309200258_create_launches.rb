# frozen_string_literal: true

class CreateLaunches < ActiveRecord::Migration[5.2]
  def change
    create_table :launches, &:timestamps
  end
end
