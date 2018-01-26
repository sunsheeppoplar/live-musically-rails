class OpportunitiesController < ApplicationController
	def new
		@employer_opportunity_form = EmployerOpportunityForm.new
	end

	def create
		@employer_opportunity_form = EmployerOpportunityForm.new(employer_opportunity_form_params)
		if @employer_opportunity_form.save
			flash[:notice] = 'Opportunity created'
			redirect_to my_profile_path
		else
			flash[:alert] = @employer_opportunity_form.errors.full_messages
			redirect_to new_opportunity_path
		end
	end

	def employer_opportunity_form_params
		if params[:category]
			params[:employer_opportunity_form][:category] = params[:category]
		end

		if params[:artist_type]
			params[:employer_opportunity_form][:artist_type] = params[:artist_type]
		end

		if params[:timeframe_of_post]
			params[:employer_opportunity_form][:timeframe_of_post] = params[:timeframe_of_post]
		end

		params.require(:employer_opportunity_form).permit(:address, :artist_type, :category, :city, :description, :event_start_date, :event_end_date, :event_end_time, :event_start_time, :name, :timeframe_of_post, :title, :zip).merge(employer: current_user)
	end
end
