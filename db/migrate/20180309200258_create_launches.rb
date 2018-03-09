class CreateLaunches < ActiveRecord::Migration[5.2]
  def change
    create_table :launches do |t|

      t.timestamps
    end
  end
end
