class AddValidationsToContexts < ActiveRecord::Migration[5.2]
  def change
    add_column :contexts, :validations, :jsonb
  end
end
