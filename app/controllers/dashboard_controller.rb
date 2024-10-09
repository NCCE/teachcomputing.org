class DashboardController < ApplicationController
  layout "full-width"
  before_action :authenticate_user!
  after_action :discourage_caching

  def show
    @incomplete_achievements = incomplete_achievements
    @completed_achievements = completed_achievements
    @enrolled_certificates, @unenrolled_certificates = enrolments
  end

  def incomplete_achievements
    current_user.achievements.not_in_state(:dropped, :complete).with_courses.order("created_at DESC")
  end

  def completed_achievements
    current_user.achievements.in_state(:complete).with_courses.order("updated_at DESC")
  end

  def enrolments
    user_enrolments = current_user.enrolments.includes(:programme)

    enrolled = user_enrolments
      .select { |enrolment| ["complete", "enrolled", "pending"].include?(current_user.programme_enrolment_state(enrolment.programme_id)) }
      .map(&:programme)

    unenrolled = Programme.where.not(id: enrolled.map(&:id))

    [enrolled, unenrolled]
  end
end
