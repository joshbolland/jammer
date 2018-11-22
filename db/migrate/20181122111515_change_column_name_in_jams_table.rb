class ChangeColumnNameInJamsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :jams, :lat, :latitude
    rename_column :jams, :lng, :longitude
  end
end
