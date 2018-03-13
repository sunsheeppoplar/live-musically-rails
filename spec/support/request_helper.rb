module Request
	module JsonHelpers
		def parsed_body
			@parsed_body ||= JSON.parse(response.body)
		end
	end
end
