class SubmissionForm
	include ActiveModel::Model
	include Virtus.model

	attribute :artist_approval, Boolean
	attribute :employer_approval, Boolean

	def update
		if valid?
			persist!
			true
		else
			false
		end
	end

	private
	def persist!

	end

	def submission_params
		{
			artist_approval: artist_approval,
			employer_approval: employer_approval
		}
	end
end