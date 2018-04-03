class RemoveDaysOfWeekFromResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :resources, :days_of_week
  end
end
