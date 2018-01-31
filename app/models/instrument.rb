class Instrument < ApplicationRecord
	has_many :artists, :through => :artist_instruments, source: :user
	has_many :artist_instruments
end