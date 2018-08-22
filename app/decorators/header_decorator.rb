class HeaderDecorator
	attr_accessor :current_user

	include ActionView::Helpers

	def initialize(current_user)
		@current_user = current_user
	end

	def html
		current_user.avatar.file? ? thumbnail_avatar : user_initials
	end

	private
	def thumbnail_avatar
		image_tag(current_user.avatar(:thumb))
	end

	def user_initials
		content_tag(:div, (current_user.first_name.first || "").capitalize + (current_user.last_name.first || "").capitalize)
	end
end