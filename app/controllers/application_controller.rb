class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	helper_method :resource_name, :resource, :devise_mapping, :resource_class, :current_user

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

	def current_user
		@current_user ||= super || GuestUser.new
	end

	def user_signed_in?
		super && !current_user.is_a?(GuestUser)
	end

	protected
	def after_sign_in_path_for(resource)
		if resource.recently_registered?
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
