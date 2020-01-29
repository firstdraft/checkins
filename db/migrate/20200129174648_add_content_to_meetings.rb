class AddContentToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :content, :text
  end
end
