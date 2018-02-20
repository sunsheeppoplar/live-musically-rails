class OpportunityPolicy
	attr_reader :current_user, :resource

	def initialize(current_user, resource)
		@current_user = current_user
		@resource = resource
	end

	def employer?
		@current_user.artist_employer?
	end

	def able_to_manage?
		@current_user.artist_employer? && @current_user.owner?(resource)
	end
end