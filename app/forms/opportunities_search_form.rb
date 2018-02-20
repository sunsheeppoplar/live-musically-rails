class OpportunitiesSearchForm
	include ActiveModel::Model

	attr_reader :event_start_time, :event_start_date, :event_end_time, :event_end_date, :instrument, :location

	def initialize(args={})
		@event_end_date = args[:event_end_date]
		@event_end_time = args[:event_end_time]
		@event_start_time = args[:event_start_time]
		@event_start_date = args[:event_start_date]
		@instrument = args[:instrument]
		@location = args[:location]
	end
end