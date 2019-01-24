# frozen_string_literal: true

class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials, &:timestamps
  end
end
