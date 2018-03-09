class AddColumnsToResource < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :meeting_schedule_hash, :string
    add_column :resources, :lis_outcome_service_url, :string
    add_column :resources, :lti_resource_link_id, :string
    add_column :resources, :context_id, :integer
  end
end
