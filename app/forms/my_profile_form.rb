class MyProfileForm
	include ActiveModel::Model
	include Virtus.model

	attribute :about, String
	attribute :current_user, Hash
	attribute :email, String
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

	def update_password
		if valid?
			persist_password!
			true
		else
			false
		end
	end

	private
	def persist!
        sanitized_hash = set_safe_hash(user_params)
        update_instruments(instruments)
        update_locations(locations)
		current_user.update!(sanitized_hash)
	end

	def persist_password!
		current_user.update!(user_password_params)
    end
    
    def update_instruments(ins_name_array)
        selected_ins_array = Instrument.where(name: ins_name_array)
        current_user.instruments = []
        current_user.instruments << selected_ins_array
        current_user.save!
        # for ins_name in ins_name_array
        #     current_ins = Instrument.where(name: ins_name)
        #     if current_ins.length == 0
        #         current_ins = [Instrument.create(name: ins_name)]
        #     end
        #     prepared_array << current_ins[0] # just in case of duplicate instruments
        # end
        # return prepared_array
    end

    def update_locations(zipcode_array)
        selected_location_array = Location.where(zipcode: zipcode_array)
        current_user.locations = []
        current_user.locations << selected_location_array
        current_user.save!
    end

    # def update_instruments(prepared_array)
    #     current_user.instruments = []
    #     current_user.instruments << prepared_array
    #     current_user.save!
    # end


	def user_params
		{
			about: about,
			email: email,
			first_name: first_name,
			last_name: last_name
		}
	end

	def user_password_params
		{
			password: password,
			password_confirmation: password_confirmation
		}
	end

	def set_safe_hash(params)
		params.reject { |k,v| v.nil? }
	end
end