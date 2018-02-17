class BasicOpportunitiesQuery
	attr_accessor :scope, :params

	def initialize(args={})
		@scope = args[:scope]
		@params = args[:params]
	end

	def call
		with_artist_type
		with_location
		with_date_range

		self.scope
	end

	def with_artist_type
		return self.scope if instrument_blank?

		self.scope = self.scope.where(artist_opportunities: {artist_type: params.instrument})
	end

	def with_location
		return self.scope if location_blank?

		self.scope = self.scope.where('venues.zip LIKE ? OR venues.city LIKE ? OR venues.state LIKE ?', location, location, location).references(:venue)
	end

	def with_date_range
		return self.scope if date_range_blank?

		self.scope = self.scope.where('event_start_date >= ? and event_end_date <= ?', event_start, event_end)
	end

	private
	def instrument_blank?
		self.params.instrument.blank?
	end

	def location
		params.location.upcase
	end

	def location_blank?
		self.params.location.blank?
	end

	def date_range_blank?
		self.params.event_start_date.blank? ||
			self.params.event_start_time.blank? ||
			self.params.event_end_date.blank? ||
			self.params.event_end_time.blank?
	end

	def event_start
		DateTime.parse("#{params.event_start_date} #{params.event_start_time}")
	end

	def event_end
		DateTime.parse("#{params.event_end_date} #{params.event_end_time}")
	end
end