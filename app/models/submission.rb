class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :opportunity
end
