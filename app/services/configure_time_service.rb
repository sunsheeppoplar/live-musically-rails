class ConfigureTimeService
	include Virtus.model

	attribute :event_end_date, DateTime
	attribute :event_end_time, String
	attribute :event_start_date, DateTime
	attribute :event_start_time, String

	attr_reader :full_date_hash

	def convert
		@start_date_object = convert_date_string(event_start_date)
		@end_date_object = convert_date_string(event_end_date)

		return_hash
	end

	def is_end_time_before_start_time?
		start_time = datetime_to_integer(@full_date_hash[:full_start_date])
		end_time = datetime_to_integer(@full_date_hash[:full_end_date])

		end_time < start_time
	end

	private
	def convert_date_string(date)
		if date.is_a? String
			DateTime.strptime(date, "%m/%d/%Y")
		end
	end


	def return_hash
		@full_date_hash = {
			full_start_date: set_date(@start_date_object,event_start_time),
			full_end_date: set_date(@end_date_object,
				event_end_time)
		}
	end

	def set_date(date, time)
		converted_time = Time.parse(time)
		date.change(hour: converted_time.hour, min: converted_time.min)
	end

	def datetime_to_integer(datetime_object)
		datetime_object.strftime("%Y%m%d%H%M").to_i
	end
end