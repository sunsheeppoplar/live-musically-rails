class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
        t.string :zipcode
        t.string :zip_code_type
        t.string :city
        t.string :state
        t.string :location_type
        t.string :lat
        t.string :long
        t.string :world_region
        t.string :country
    end
  end
end
