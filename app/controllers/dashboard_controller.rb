class DashboardController < ApplicationController
  layout "full-width"
  before_action :authenticate_user!
  after_action :discourage_caching

  def show
    @incomplete_achievements = get_incomplete_achievements
    @completed_achievements = get_completed_achievements
    @enrolled_certificates, @unenrolled_certificates = get_certificates
  end

  def get_incomplete_achievements
    current_user.achievements.not_in_state(:dropped, :complete).with_courses.order("created_at DESC")
  end

  def get_completed_achievements
    current_user.achievements.in_state(:complete).with_courses.order("updated_at DESC")
  end

  def get_certificates
    user_enrolments = current_user.enrolments.includes(:programme)

    enrolled = user_enrolments
      .select { |enrolment| current_user.programme_enrolment_state(enrolment.programme_id) == "enrolled" }
      .map(&:programme)

    unenrolled = Programme.where.not(id: enrolled.map(&:id))

    [enrolled, unenrolled]
  end
end
