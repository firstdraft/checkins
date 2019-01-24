# frozen_string_literal: true

class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins, &:timestamps
  end
end
