class Submission < ApplicationRecord
	belongs_to :user
	belongs_to :opportunity, optional: true

	enum artist_decision: { pending_artist: 0, approved_by_artist: 1, declined_by_artist: 2 }
	enum employer_decision: { pending_employer: 0, approved_by_emplyer: 1, declined_by_emplyer: 2 }
end
