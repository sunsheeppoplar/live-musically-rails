class ArtistOpportunity < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :opportunity
end
