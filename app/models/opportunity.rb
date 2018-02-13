class Opportunity < ApplicationRecord
	belongs_to :employer, :class_name => 'User'
	has_many :artist_opportunities, dependent: :destroy
	has_many :artists, :through => :artist_opportunities, source: :user
	has_one :venue, dependent: :destroy
end
