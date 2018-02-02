class OpportunityDecorator
	attr_accessor :opportunity

	def initialize(opportunity)
		@opportunity = opportunity
	end

	def id
		@opportunity.id
	end

	def formatted_date
		@opportunity.event_start_date.strftime("%m/%d/%Y")
	end

	def formatted_time
		@opportunity.event_start_date.strftime("%-l:%M %p")
	end

	def full_address
		"#{@opportunity.venue.city}, #{opportunity.venue.state}"
	end

end