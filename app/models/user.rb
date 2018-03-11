class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable,
	:omniauthable, :omniauth_providers => [:facebook, :stripe_connect]

	enum role: { musician: 0, artist_employer: 1 }

	has_many :employing_opportunities, :class_name => 'Opportunity', :foreign_key => 'employer_id'
	has_many :artist_opportunities
	has_many :performing_opportunities, :through => :artist_opportunities, source: :opportunity
	has_many :instruments, :through => :artist_instruments
	has_many :artist_instruments
	has_many :locations, :through => :artist_locations
	has_many :artist_locations
	has_many :external_links
	has_many :submissions
	has_many :oauth_identities, dependent: :destroy

	has_attached_file	:avatar,
						:styles => {
							normal: ["250x250#", :png],
							small: ["215x215#", :png],
							thumb: ["50x50#", :png]
						}
	validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def owner?(opportunity)
		id == opportunity.employer_id
	end

	def recently_registered?
		not_stripe_user? && sign_in_count == 1
	end

	def not_stripe_user?
		OauthIdentity.where(provider: "stripe_connect", user_id: self.id).count < 1
	end

end
	