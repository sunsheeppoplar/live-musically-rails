class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :opportunity, optional: true
end
