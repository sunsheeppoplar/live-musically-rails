class OpportunityPolicy
	attr_reader :current_user, :resource

	def initialize(current_user, resource)
		@current_user = current_user
		@resource = resource
	end

	def fully_onboarded_employer?
		current_user.artist_employer? && !current_user.not_stripe_user?
	end

	def partially_onboarded_employer?
		current_user.artist_employer?
	end

	def fully_onboarded_musician?
		current_user.musician? && !current_user.not_stripe_user?
	end

	def partially_onboarded_musician?
		current_user.musician?
	end

	def able_to_manage?
		current_user.artist_employer? && current_user.owner?(resource)
	end

	def artist?
		current_user.musician?
	end
end