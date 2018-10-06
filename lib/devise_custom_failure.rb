class DeviseCustomFailure < Devise::FailureApp
	def redirect_url
		auth_path
	end

	def respond
		# if http_auth?
		# 	http_auth
		# else
		# 	redirect
		# end
		if request.format == :json
			json_error_response
		else
			super
		end
	end

	def json_error_response
		self.status = 401
		self.content_type = "application/json"
		self.response_body = { error: i18n_message }.to_json
	end
end