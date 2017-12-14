class CreateArtistProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_profiles do |t|
      t.text :about
      t.integer :desired_compensation_lower_bound
      t.integer :desired_compensation_upper_bound
      t.string :youtube_link
      t.string :facebook_link
      t.string :instagram_link
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
