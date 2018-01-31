class CreateArtistInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_instruments do |t|
      t.references :instrument, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
