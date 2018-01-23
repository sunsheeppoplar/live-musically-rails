class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable,
	:omniauthable, :omniauth_providers => [:facebook]

	enum role: { musician: 0, artist_employer: 1 }

	enum instrument: ARTIST_INSTRUMENTS.each do |value|
		[value]
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			parse_name(user, auth.info.name)
			user.role = auth.user_role
		end
	end

	private
	def self.parse_name(user, name)
		name_arr = name.split(" ")
		user.last_name = name_arr.pop
		user.first_name = name_arr.join(" ")
	end
end
	