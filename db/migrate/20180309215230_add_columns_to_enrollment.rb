class AddColumnsToEnrollment < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :roles, :string
    add_column :enrollments, :user_id, :integer
    add_column :enrollments, :context_id, :integer
  end
end
