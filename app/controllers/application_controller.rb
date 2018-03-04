class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	helper_method :resource_name, :resource, :devise_mapping, :resource_class

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def resource_class
		User
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	protected
	def after_sign_in_path_for(resource)
		binding.pry
		if resource.is_a?(User) && resource.not_stripe_user?
			onboard_path
		else
			super
		end
	end

	private
	def authenticate_user!
		if user_signed_in?
			super
		else
			redirect_to auth_path, notice: "Please Login to view that page!"
		end
	end
end
