class SubmissionDecorator
	attr_reader :submission, :user

	def initialize(submission)
		@submission = submission
		@user = submission.user
	end

	def self.wrap(collection)
		unless collection.nil?
			collection.map do |submission|
				new submission
			end
		end
	end

	def avatar_link
		"https:" + user.avatar.url(:thumb)
	end

	def full_name
		"#{user.first_name + " " + user.last_name}"
	end
end