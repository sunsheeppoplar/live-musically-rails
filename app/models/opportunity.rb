class Opportunity < ApplicationRecord
	has_one :venue
	belongs_to :employer, :class_name => 'User'
	has_many :artist_opportunities
	has_many :artists, :through => :artist_opportunities, source: :user

	enum artist_type: ARTIST_INSTRUMENTS.each do |value|
		[value]
	end
end
