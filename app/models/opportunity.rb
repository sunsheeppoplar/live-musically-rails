class Opportunity < ApplicationRecord
	belongs_to :employer, :class_name => 'User'
	has_many :artist_opportunities
	has_many :artists, :through => :artist_opportunities, source: :user
	has_many :artist_types
	has_one :venue

	enum artist_type: ARTIST_INSTRUMENTS.each do |value|
		[value]
	end
end
