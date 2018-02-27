module Apply
	class OpportunitiesController < ApplicationController
		before_action :authenticate_user!

		def new
			respond_to do |format|
				if opportunity_policy.artist?
					opportunity = Opportunity.find(params[:opp_id])
					@opportunity_apply_form = OpportunityApplyForm.new(opportunity: opportunity)
					format.json {
						render json: {new_application: partial_to_string }, status: 200
					}
				else
					format.json {
						render json: {error: "Not authorized, sorry!", location: root_path}, status: 403
					}
				end
			end
		end

		def create
			@opportunity_apply_form = OpportunityApplyForm.new(submission_params.merge(current_user: current_user))
			if opportunity_policy.artist?
				if @opportunity_apply_form.save
					redirect_to root_path, notice: "Your application was submitted!"
				else
					redirect_to root_path, alert: "Sorry, something went wrong!"
				end
			else
				redirect_to root_path, status: 403, alert: "Not authorized, sorry!"
			end
		end

		private
		def opportunity_policy
			OpportunityPolicy.new(current_user, nil)
		end

		def partial_to_string
			render_to_string(partial: 'apply/opportunities/show', layout: false, formats: [:html], locals: { opportunity_apply_form: @opportunity_apply_form})
		end

		def submission_params
			params.require(:opportunity_apply_form).permit(:opportunity_id)
		end
	end
end