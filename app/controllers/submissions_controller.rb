class SubmissionsController < ApplicationController
	before_action :authenticate_user!

	def index
		@submissions = Submission.includes(:user).where(opportunity_id: params[:opportunity_id])
	end

	private
end