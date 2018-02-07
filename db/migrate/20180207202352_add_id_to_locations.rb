class AddIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :location_id, :primary_key
  end
end
