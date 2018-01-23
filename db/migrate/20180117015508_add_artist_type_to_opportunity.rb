class AddArtistTypeToOpportunity < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :artist_type, :integer
  end
end
