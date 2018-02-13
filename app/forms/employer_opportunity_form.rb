class EmployerOpportunityForm
	include ActiveModel::Model
	include Virtus.model
	include ActiveModel::Validations
	include ActiveModel::Validations::Callbacks

	attribute :address, String
	attribute :artist_types, Array[String]
	attribute :category, String
	attribute :city, String
	attribute :description, String
	attribute :employer, Hash
	attribute :event_end_date, DateTime
	attribute :event_end_time, String
	attribute :event_start_date, DateTime
	attribute :event_start_time, String
	attribute :name, String
	attribute :state, String
	attribute :timeframe_of_post, String
	attribute :title, String
	attribute :zip, Integer

	attr_reader :venue, :opportunity, :artist_types

	before_validation { self.state = self.state.upcase }

	# time & date related validations for presence always pass because we set the values through js on page load

	validates :address, presence: true
	validates :artist_types, presence: true
	validates :category, presence: true
	validates :city, presence: true
	validates :description, presence: true
	validates :name, presence: true
	validates :state, presence: true
	validates :timeframe_of_post, presence: true
	validates :title, presence: true
	validates :zip, presence: true
	validates_inclusion_of :state, :in => STATES_ARRAY

	validate :is_timerange_valid?

	def initialize(attr={})
		if attr[:id]
			@opportunity = Opportunity.includes(:venue, :employer).find(attr[:id])
			@artist_types = Opportunity.joins(:artist_opportunities).where(id: attr[:id]).pluck(:'artist_type')
			@venue = @opportunity.venue

			event_times = ConfigureTimeService.new(
				event_end_date: @opportunity.event_end_date,
				event_start_date: @opportunity.event_start_date
			).find_event_times

			self.address = attr[:address].nil? ?						@venue.address :					attr[:address]
			self.artist_types = attr[:artist_types].nil? ?				@artist_types :						attr[:artist_types]
			self.category = attr[:category].nil? ?						@venue.category :					attr[:category]
			self.city = attr[:city].nil? ?								@venue.city :						attr[:city]
			self.description = attr[:description].nil? ?				@opportunity.description :			attr[:description]
			self.event_end_date = attr[:event_end_date].nil? ?			@opportunity.event_start_date :		attr[:event_end_date]
			self.event_end_time = attr[:event_end_time].nil? ?			event_times[:end_time] :			attr[:event_end_time]
			self.event_start_date = attr[:event_start_date].nil? ?		@opportunity.event_start_date :		attr[:event_start_date]
			self.event_start_time = attr[:event_start_time].nil? ?		event_times[:start_time] :			attr[:event_start_time]
			self.name = attr[:name].nil? ?								@venue.name :						attr[:name]
			self.state = attr[:state].nil? ?							@venue.state :						attr[:state]
			self.timeframe_of_post = attr[:timeframe_of_post].nil? ?	nil :								attr[:timeframe_of_post]
			self.title = attr[:title].nil? ?							@opportunity.title :				attr[:title]
			self.zip = attr[:zip].nil? ?								@venue.zip :						attr[:zip]
		else
			super(attr)
		end
	end

	def save
		if valid?
			persist!
			true
		else
			false
		end
	end

	def update
		if valid?
			update!
			true
		else
			false
		end
	end

	def is_timerange_valid?
		@time_service = ConfigureTimeService.new(event_params)
		@time_service.convert
		if @time_service.is_end_time_before_start_time?
			errors.add(:event_end_time, "can't be before start time")
		end
	end

	def is_checked?(attribute_checked, data_checked_against)
		if attribute_checked
			attribute_checked.include?(data_checked_against)
		else
			nil
		end
	end

	def destroy
		destroy!
	end

	private
	def persist!
		opportunity = employer.employing_opportunities.create!(
			description: description,
			event_end_date: @time_service[:full_date_hash][:full_start_date],
			event_start_date: @time_service[:full_date_hash][:full_end_date],
			timeframe_of_post: @time_service[:full_date_hash][:timeframe_of_post],
			title: title
		)
		artist_types.each do |artist_type|
			opportunity.artist_opportunities.create(artist_type: artist_type)
		end
		@venue = opportunity.create_venue!(
			address: address,
			category: category,
			city: city,
			name: name,
			state: state,
			zip: zip
		)
	end

	def event_params
		{   event_end_date: event_end_date,
			event_end_time: event_end_time,
			event_start_date: event_start_date,
			event_start_time: event_start_time,
			timeframe_of_post: timeframe_of_post }
	end

	def update!
		@opportunity.update!(opportunity_params)
		@venue.update!(venue_params)
		@opportunity.artist_opportunities = []
		self.artist_types.each do |artist_type|
			@opportunity.artist_opportunities.create(artist_type: artist_type)
		end
	end

	def opportunity_params
		{
			description: description,
			event_end_date: @time_service[:full_date_hash][:full_start_date],
			event_start_date: @time_service[:full_date_hash][:full_end_date],
			timeframe_of_post: @time_service[:full_date_hash][:timeframe_of_post],
			title: title
		}
	end

	def venue_params
		{
			address: self.address,
			category: self.category,
			city: self.city,
			name: self.name,
			state: self.state,
			zip: self.zip
		}
	end

	def destroy!
		@opportunity.destroy!
	end
end