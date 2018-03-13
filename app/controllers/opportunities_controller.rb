class OpportunitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_opportunity, only: [:edit, :destroy]

	def new
		if opportunity_policy.fully_onboarded_employer?
			@employer_opportunity_form = EmployerOpportunityForm.new
		elsif opportunity_policy.partially_onboarded_employer?
			redirect_to onboard_path, notice: "Please complete Stripe registration before posting an opportunity"
		else
			redirect_to root_path, alert: "Not authorized, sorry!"
		end
	end

	def show
		opportunity = Opportunity.includes(:artist_opportunities, :employer, :venue).find(params[:id])
		@opportunity = OpportunityDecorator.new(opportunity)
	end

	def create
		@employer_opportunity_form = EmployerOpportunityForm.new(employer_opportunity_form_params)
		respond_to do |format|
			if @employer_opportunity_form.save
				format.html { redirect_to my_profile_path, notice: "Opportunity created" }
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

	def edit
		if opportunity_policy.able_to_manage?
			@employer_opportunity_form = EmployerOpportunityForm.new(id: params[:id])
		else
			redirect_to root_path, alert: "Not authorized, sorry!"
		end
	end

	def update
		if opportunity_policy.able_to_manage?
			@employer_opportunity_form = EmployerOpportunityForm.new(employer_opportunity_form_params.merge(id: params[:id]))
			respond_to do |format|
				if @employer_opportunity_form.update
					format.html { redirect_to my_profile_path, notice: "Opportunity updated"}
					format.json { render json: @employer_opportunity_form, status: :ok, location: my_profile_url }
				else
					format.html {}
					format.json { render json: {errors: @employer_opportunity_form.errors, full_messages: @employer_opportunity_form.errors.full_messages}, status: :unprocessable_entity
					}
				end
			end
		else
			redirect_to root_path, alert: "Not authorized, sorry!"
		end
	end

	def destroy
		if opportunity_policy.able_to_manage?
			@employer_opportunity_form = EmployerOpportunityForm.new(id: params[:id])
			respond_to do |format|
				if @employer_opportunity_form.destroy
					format.html { redirect_to my_profile_path, notice: "Opportunity was successfully deleted" }
					format.json { head :no_content }
				else
					format.html {}
					format.json {}
				end
			end
		else
			redirect_to root_path, alert: "Not authorized, sorry!"
		end
	end

	private
	def set_opportunity
		@opportunity = Opportunity.find(params[:id])
	end

	def opportunity_policy
		OpportunityPolicy.new(current_user, @opportunity)
	end

	def employer_opportunity_form_params
		params.require(:employer_opportunity_form).permit(:address, :category, :city, :description, :event_start_date, :event_end_date, :event_end_time, :event_start_time, :name, :state, :timeframe_of_post, :title, :zip, :artist_types => []).merge(employer: current_user)
	end
end