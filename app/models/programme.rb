class Programme < ApplicationRecord
  has_many :programme_activities, dependent: :destroy
  has_many :activities, through: :programme_activities
  has_many :user_programme_enrolments, dependent: :restrict_with_exception
  has_many :users, through: :user_programme_enrolments

  validates :title, :description, :slug, presence: true

  def is_user_enrolled?(user = nil)
    return false if user.nil?
    user.programmes.exists?(self.id)
  end
end
