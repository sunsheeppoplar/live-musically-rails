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
	attribute :event_duration, Integer
	attribute :event_end_date, DateTime
	attribute :event_end_time, String
	attribute :event_start_date, DateTime
	attribute :event_start_time, String
	attribute :name, String
	attribute :state, String
	attribute :timeframe_of_post, String
	attribute :title, String
	attribute :zip, Integer

	attr_reader :venue

	before_validation { self.state = self.state.upcase }

	# validates :title, presence: true
	# validates :category, presence: true
	validate :is_timerange_valid?
	validates_inclusion_of :state, :in => STATES_ARRAY

	def save
		if valid?
			persist!
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
		{ 	event_end_date: event_end_date,
			event_end_time: event_end_time,
			event_start_date: event_start_date,
			event_start_time: event_start_time,
			timeframe_of_post: timeframe_of_post }
	end
end