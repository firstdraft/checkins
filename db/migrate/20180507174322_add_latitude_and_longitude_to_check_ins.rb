class AddLatitudeAndLongitudeToCheckIns < ActiveRecord::Migration[5.2]
  def change
    add_column :check_ins, :latitude, :float
    add_column :check_ins, :longitude, :float
  end
end
