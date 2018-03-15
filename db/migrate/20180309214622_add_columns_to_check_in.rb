class AddColumnsToCheckIn < ActiveRecord::Migration[5.2]
  def change
    add_column :check_ins, :present, :boolean, default: true
    add_column :check_ins, :late, :boolean
    add_column :check_ins, :enrollment_id, :integer
    add_column :check_ins, :resource_id, :integer
  end
end
