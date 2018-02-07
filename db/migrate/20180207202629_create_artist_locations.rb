class CreateArtistLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_locations do |t|
        t.references :location, foreign_key: true
        t.references :user, foreign_key: true
    end
  end
end
