class ExternalLink < ApplicationRecord
    belongs_to :user

    validates_with ExternalLinkValidator
end