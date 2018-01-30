class RegistrationsController < Devise::RegistrationsController

	private

	def sign_up_params
		binding.pry
		params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :role)
	end
end