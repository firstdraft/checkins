class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :preferred_name, :string
    add_column :users, :lti_user_id, :string
  end
end
