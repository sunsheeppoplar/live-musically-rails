class Opportunity < ApplicationRecord
	has_one :venue
	enum artist_type: ARTIST_INSTRUMENTS.each do |value|
		[value]
	end
end
