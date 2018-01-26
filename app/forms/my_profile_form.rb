class MyProfileForm
	include ActiveModel::Model
	include Virtus.model

	attribute :about, String
	attribute :current_user, Hash

	def update
		if valid?
			persist!
			true
		else
			false
		end
	end

	private
	def persist!
		current_user.update(user_params)
	end

	def user_params
		{
			about: about
		}
	end
end