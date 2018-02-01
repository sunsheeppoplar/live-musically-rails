class ProfilesController < ApplicationController
	before_action :authenticate_user!
	
	def my_profile
		layout = find_user_role(current_user.role)
		@my_profile_form = MyProfileForm.new(current_user: current_user)
		render layout
	end

	def update
		@my_profile_form = MyProfileForm.new(profile_form_params)
		respond_to do |format|
			if @my_profile_form.update
				# flash[:notice] = 'Updated'
				format.json { render json: { my_profile_form: @my_profile_form }
				}
				format.html { redirect_to my_profile_path, notice: 'Updated'}
			else
				# flash[:alert]
				redirect_to my_profile_path
			end
		end
	end

	def update_password
		@my_profile_form = MyProfileForm.new(profile_form_params)
		@user = @my_profile_form.current_user

		respond_to do |format|
			if @my_profile_form.update_password
				bypass_sign_in(@user)
				# flash[:notice] = 'Updated'
				format.json { render json: { my_profile_form: @my_profile_form }
				}
				format.html { redirect_to my_profile_path, notice: 'Updated'}
			else
				# flash[:alert]
				redirect_to my_profile_path
			end
		end
    end
    
	private
	def profile_form_params
		params.require(:my_profile_form).permit(:about, :email, :first_name, :last_name, :password, :password_confirmation).merge(current_user: current_user)
	end

	def find_user_role(role)
		if role == "musician"
			"artist_profile.html.erb"
		else
			"employer_profile.html.erb"
		end
	end
end