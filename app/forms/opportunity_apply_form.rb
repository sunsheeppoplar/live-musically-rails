class OpportunityApplyForm
	include ActiveModel::Model
	include Virtus.model
	include ActiveModel::Validations

	attribute :current_user, Hash
	attribute :opportunity, Hash
	attribute :opportunity_id, Integer

	validates :opportunity_id, presence: true
	validate :prior_submission?

	def title
		opportunity.title.upcase
	end

	def opp_id
		opportunity.id
	end

	def save
		if valid?
			persist!
			true
		else
			false
		end
	end

	private
	def prior_submission?
		if Submission.where(opportunity_id: opportunity_id, user_id: current_user.id).count > 0
			errors.add(:opportunity, "can't be submitted to more than once")
		end
	end

	def persist!
		current_user.submissions.create(submission_params)
	end

	def submission_params
		{
			opportunity_id: opportunity_id
		}
	end
end