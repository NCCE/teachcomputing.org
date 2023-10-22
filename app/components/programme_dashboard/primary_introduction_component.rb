class ProgrammeDashboard::PrimaryIntroductionComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  attr_reader :user_programme_enrolment

  def before_render
    @user_programme_enrolment = current_user.user_programme_enrolments.find_by(programme: Programme.primary_certificate)
  end
end
