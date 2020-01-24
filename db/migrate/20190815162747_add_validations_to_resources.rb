class AddValidationsToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :validations, :jsonb
  end
end
