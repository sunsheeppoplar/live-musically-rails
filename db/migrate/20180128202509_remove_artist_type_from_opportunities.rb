class RemoveArtistTypeFromOpportunities < ActiveRecord::Migration[5.0]
  def change
    remove_column :opportunities, :artist_type, :integer
  end
end
