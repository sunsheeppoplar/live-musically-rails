class ConfigureTimeService
	include Virtus.model

	attribute :event_end_date, DateTime
	attribute :event_end_time, String
	attribute :event_start_date, DateTime
	attribute :event_start_time, String

	def convert
		@start_date_object = convert_date_string(event_start_date)
		@end_date_object = convert_date_string(event_end_date)

		return_hash
	end

	private
	def convert_date_string(date)
		if date.is_a? String
			DateTime.strptime(date, "%m/%d/%Y")
		end
	end

	def return_hash
		{
			full_start_date: set_date(@start_date_object, event_start_time),
			full_end_date: set_date(@end_date_object, event_end_time)
		}
	end

	def set_date(date, time)
		converted_time = Time.parse(time)
		date.change(hour: converted_time.hour, min: converted_time.min)
	end
end