# frozen_string_literal: true

class AddDayColumnsToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :sunday,    :boolean, default: false
    add_column :resources, :monday,    :boolean, default: false
    add_column :resources, :tuesday,   :boolean, default: false
    add_column :resources, :wednesday, :boolean, default: false
    add_column :resources, :thursday,  :boolean, default: false
    add_column :resources, :friday,    :boolean, default: false
    add_column :resources, :saturday,  :boolean, default: false
  end
end
