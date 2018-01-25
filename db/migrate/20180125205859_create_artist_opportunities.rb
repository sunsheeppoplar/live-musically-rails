class CreateArtistOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_opportunities do |t|
    	t.belongs_to :opportunity, index: true
    	t.belongs_to :user, index: true
    	t.timestamps
    end
  end
end
