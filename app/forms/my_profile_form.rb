class MyProfileForm
	include ActiveModel::Model
	include Virtus.model

    attribute :about, String
    attribute :avatar, Hash
	attribute :current_user, Hash
    attribute :email, String
    attribute :soundcloud_links, Array
    attribute :youtube_links, Array
	attribute :first_name, String
	attribute :instruments, Array
    attribute :last_name, String
    attribute :locations, Array
	attribute :password, String
    attribute :password_confirmation, String
    
	# validates :last_name, presence: true

    def update
        if valid?
			persist!
			true
        else
			false
		end
	end

    def updating_password?
        password.present? && password_confirmation.present?
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
        update_instruments(instruments)
        update_locations(locations)
        update_soundcloud_links(soundcloud_links)
        update_youtube_links(youtube_links)
        update_avatar
		current_user.update!(sanitized_hash)
	end
    
    def update_instruments(ins_name_array)
        selected_ins_array = Instrument.where(name: ins_name_array)
        current_user.instruments = []
        current_user.instruments << selected_ins_array
        current_user.save!
    end

    def update_locations(zipcode_array)
        selected_location_array = Location.where(zipcode: zipcode_array)
        current_user.locations = []
        current_user.locations << selected_location_array
        current_user.save!
    end

    def update_soundcloud_links(sc_link_array)
        current_user.external_links.where(origin_site:"sc").destroy_all
        sc_link_array.each_with_index do |link, index|
            if index < 3
                current_user.external_links.create(origin_site:"sc", link_to_content: link)
            end
        end
        current_user.save!
    end

    def update_youtube_links(yt_link_array)
        current_user.external_links.where(origin_site:"yt").destroy_all
        yt_link_array.each_with_index do |link, index|
            if index < 2
            current_user.external_links.create(origin_site:"yt", link_to_content: link)
            end
        end
        current_user.save!
    end

    def update_avatar
        if avatar != {}
            current_user.avatar = avatar
            current_user.save!
        end
    end

	def user_params
		{
			about: about,
			email: email,
			first_name: first_name,
			last_name: last_name,
            password: password,
            password_confirmation: password_confirmation
		}
	end

	def set_safe_hash(params)
		params.reject { |k,v| v.nil? }
    end
    
end