class SupportAudit < Audited::Audit
  before_create :add_actuating_user_details
  
  belongs_to :authoriser, :foreign_key => 'authoriser_id', required: false

  validates :authoriser_id, presence: true, on: :update
  validates :comment, presence: true, on: :update

  def add_actuating_user_details
    user = User.find_by_email(username)
    return if user.blank?

    self.user_id = user.id
    self.user_type = 'teachcomputing'
  end
end
