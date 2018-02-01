class OpportunitiesController < ApplicationController
	def new
		@employer_opportunity_form = EmployerOpportunityForm.new
	end

	def create
		@employer_opportunity_form = EmployerOpportunityForm.new(employer_opportunity_form_params)
		respond_to do |format|
			if @employer_opportunity_form.save
				format.html { redirect_to my_profile_path, notice: 'Opportunity created' }
				format.json { render json: @employer_opportunity_form, status: :created, location: my_profile_url }
			else
				format.html {
					render action: "new"
				}
				format.json { render json: {errors: @employer_opportunity_form.errors, full_messages: @employer_opportunity_form.errors.full_messages}, status: :unprocessable_entity
				}
			end
		end
	end

	def employer_opportunity_form_params
		params.require(:employer_opportunity_form).permit(:address, :category, :city, :description, :event_start_date, :event_end_date, :event_end_time, :event_start_time, :name, :state, :timeframe_of_post, :title, :zip, :artist_types => []).merge(employer: current_user)
	end
end