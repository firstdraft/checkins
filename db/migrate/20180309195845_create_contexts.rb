# frozen_string_literal: true

class CreateContexts < ActiveRecord::Migration[5.2]
  def change
    create_table :contexts, &:timestamps
  end
end
