# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources, &:timestamps
  end
end
