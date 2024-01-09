class SentEmail < ApplicationRecord
  belongs_to :user

  validates :user, :mailer_type, presence: true
  validates :user, uniqueness: {scope: [:mailer_type]}

  scope :mailer_type_for_user, lambda { |user, mailer_type|
    where(user: user, mailer_type: mailer_type)
  }
end
