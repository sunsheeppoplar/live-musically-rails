class MyProfileForm
	include ActiveModel::Model
	include Virtus.model

	attribute :about, String
	attribute :current_user, Hash
	attribute :email, String
	attribute :first_name, String
	attribute :last_name, String
	attribute :password, String
	attribute :password_confirmation, String

	validates :last_name, presence: true

	def update
		if valid?
			persist!
			true
		else
			false
		end
	end

	def update_password
		if valid?
			persist_password!
			true
		else
			false
		end
	end

	# decorators
	def decorated_employing_opportunities
		opp = Opportunity.includes(:venue).where(employer_id: current_user.id)
		opp.map do |o|
			OpportunityDecorator.new(o)
		end
	end

	private
	def persist!
		sanitized_hash = set_safe_hash(user_params)
		current_user.update!(sanitized_hash)
	end

	def persist_password!
		current_user.update!(user_password_params)
	end

	def user_params
		{
			about: about,
			email: email,
			first_name: first_name,
			last_name: last_name
		}
	end

	def user_password_params
		{
			password: password,
			password_confirmation: password_confirmation
		}
	end

	def set_safe_hash(params)
		params.reject { |k,v| v.nil? }
	end
end