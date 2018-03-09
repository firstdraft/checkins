class AddColumnsToLaunch < ActiveRecord::Migration[5.2]
  def change
    add_column :launches, :payload, :jsonb
    add_column :launches, :enrollment_id, :integer
    add_column :launches, :credential_id, :integer
  end
end
