class SupportAudit < Audited::Audit
  before_create :add_actuating_user_details, :add_affected_user_details

  belongs_to :user, optional: true
  belongs_to :affected_user, class_name: "User", foreign_key: :affected_user_id, optional: true
  belongs_to :authoriser, foreign_key: :authoriser_id, optional: true

  validates :authoriser_id, presence: true, on: :update
  validates :comment, presence: true, on: :update

  # always use the default admin user
  def add_actuating_user_details
    admin_user = User.find_by_email(ENV.fetch("DEFAULT_ADMIN_EMAIL"))
    return if admin_user.blank?

    self.user_id = admin_user.id
    self.username = admin_user.email
    self.user_type = "teachcomputing"
  end

  def add_affected_user_details
    self.affected_user_id = auditable.is_a?(User) ? auditable.id : nil
    return unless affected_user_id.nil?

    self.affected_user_id = auditable.respond_to?(:user_id) ? auditable.user_id : nil
  end
end
