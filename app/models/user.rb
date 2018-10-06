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
	has_one :artist_profile
    has_one :subscription

	has_attached_file	:avatar,
						:styles => {
							normal: ["250x250#", :png],
							small: ["215x215#", :png],
							thumb: ["50x50#", :png]
						},
						:default_url => ActionController::Base.helpers.asset_path("avatars/:style/missing.png")

	# validates_attachment_content_type :cropped_avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	do_not_validate_attachment_file_type :avatar

	validates :first_name, presence: true
	validates :last_name, presence: true

	def included_conversations
		Conversation.includes(:messages).where("sender_id = ? OR recipient_id = ?", self.id, self.id)
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			parse_name(user, auth.info.name)
			user.role = auth.user_role
		end
	end

	def owner?(opportunity)
		id == opportunity.employer_id
	end

	def recently_registered?
		not_stripe_subscribed? && not_stripe_payable? && sign_in_count == 1
	end

	def not_stripe_subscribed?
		stripe_customer_token.blank?
	end

	def not_stripe_payable?
		OauthIdentity.where(provider: "stripe_connect", user_id: self.id).count < 1
	end
end
	