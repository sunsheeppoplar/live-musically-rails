class ProfilesController < ApplicationController
	before_action :authenticate_user!
	
	def my_profile
		layout = find_user_role(current_user.role)
		@my_profile_form = MyProfileForm.new(current_user: current_user)
		respond_to do |format|
			format.html { render layout }
			format.json { render json:
				{
					instruments: current_user.instruments,
					locations: current_user.locations,
					ext_links: current_user.external_links
				}
			}
		end
	end

	def update
		@my_profile_form = MyProfileForm.new(profile_form_params)
		respond_to do |format|
			if @my_profile_form.update
				if @my_profile_form.updating_password?
					bypass_sign_in(@my_profile_form.current_user)
				end
				# flash[:notice] = 'Updated'
				format.html { redirect_to my_profile_path, notice: 'Updated'
				}
				# prevents UndefinedConversionError
				@my_profile_form.avatar = {}
				format.json { render json: @my_profile_form
				}
			else
				# flash[:alert]
				format.html { redirect_to my_profile_path }
			end
		end
	end

	def get_single_zipcode
		@location  = Location.where(zipcode: params[:zipcode])
		respond_to do |format|
			format.html { redirect_to my_profile_path, notice: 'Updated'
			}
			format.json { render json: { location: @location }
			}
		end
	end

	private
	def profile_form_params
		params.require(:my_profile_form).permit(:about, :avatar, :email, :first_name, :last_name, :password, :password_confirmation, :instruments => [], :locations => [], :soundcloud_links => [], :youtube_links => [])
			.merge(current_user: current_user)
			.reject {|k, v| (k == "password_confirmation" || k == "password") && v.blank? }
	end

	def find_user_role(role)
		if role == "musician"
			"artist_profile.html.erb"
		else
			"employer_profile.html.erb"
		end
	end
end