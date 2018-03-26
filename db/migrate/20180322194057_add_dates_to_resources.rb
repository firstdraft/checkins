class AddDatesToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :starts_on, :date
    add_column :resources, :ends_on, :date
    add_column :resources, :days_of_week, :string, array: true
  end
end
