class AddAllowedAbsencesToContexts < ActiveRecord::Migration[5.2]
  def change
    add_column :contexts, :allowed_absences, :integer, default: 0
  end
end
