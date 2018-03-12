class SubmissionsController < ApplicationController
	before_action :authenticate_user!

	def index
		submissions = Submission.includes(:user).where(opportunity_id: params[:opportunity_id])
		opportunity = Opportunity.find(params[:opportunity_id])

		@opportunity = OpportunityDecorator.new(opportunity)
		@submissions = SubmissionDecorator.wrap(submissions)
	end

	private
end