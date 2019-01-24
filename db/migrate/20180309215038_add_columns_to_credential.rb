# frozen_string_literal: true

class AddColumnsToCredential < ActiveRecord::Migration[5.2]
  def change
    add_column :credentials, :consumer_key, :string
    add_column :credentials, :consumer_secret, :string
    add_column :credentials, :administrator_id, :integer
    add_column :credentials, :enabled, :boolean, default: true
  end
end
