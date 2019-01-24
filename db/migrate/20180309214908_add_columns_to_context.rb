# frozen_string_literal: true

class AddColumnsToContext < ActiveRecord::Migration[5.2]
  def change
    add_column :contexts, :title, :string
    add_column :contexts, :lti_context_id, :string
    add_column :contexts, :credential_id, :integer
  end
end
