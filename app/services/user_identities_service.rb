class UserIdentitiesService
	attr_accessor :identity, :user

	def self.from_omniauth(auth, user = nil)
		@identity = OauthIdentity.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |oauth_identity|
			user ||= oauth_identity.build_user.tap do |u| 
				u.email = auth.info.email
				u.password = Devise.friendly_token[0,20]
				parse_name(u, auth.info.name)
				u.role = auth.user_role
			end
			oauth_identity.user_id = user.id
			oauth_identity.save
			@user = user
		end
	end

	def persisted?
		@identity.persisted?
	end

	def user
		@user
	end

	private
	def self.parse_name(user, name)
		name_arr = name.split(" ")
		user.last_name = name_arr.pop
		user.first_name = name_arr.join(" ")
	end
end