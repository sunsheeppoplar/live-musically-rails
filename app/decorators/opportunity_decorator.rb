class OpportunityDecorator
	attr_accessor :opportunity

	def initialize(opportunity)
		@opportunity = opportunity
	end

	def self.wrap(collection)
		unless collection.nil?
			collection.map do |object|
				new object
			end
		end
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

	def title
		@opportunity.title.upcase
	end

	def employer
		"#{@opportunity.employer.first_name.upcase} #{@opportunity.employer.last_name.upcase}"
	end

	def event_date
		@opportunity.event_start_date.strftime("%a, %b, #{date_as_ordinal} %Y").upcase
	end

	def venue_name
		@opportunity.venue.name
	end

	def venue_full_address
		"#{@opportunity.venue.address}, #{@opportunity.venue.city}, #{@opportunity.venue.state}"
	end

	def id
		@opportunity.id
	end

	def submissions_count
		"#{(opportunity.submissions.count)}"
	end

	private
	def date_as_ordinal
		@opportunity.event_start_date.strftime("%e").to_i.ordinalize
	end
end