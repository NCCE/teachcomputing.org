class DashboardController < ApplicationController
  layout "full-width"
  before_action :authenticate_user!
  after_action :discourage_caching

  def show
    @incomplete_achievements = incomplete_achievements
    @completed_achievements = completed_achievements
    @enrolled_certificates, @unenrolled_certificates = enrolments

    user_course_info = Achiever::Course::Delegate.find_by_achiever_contact_number(current_user.stem_achiever_contact_no)
    @user_course_info = user_course_info.select { |course| %w[enrolled attended].include?(course.attendance_status) }
  end

  private

  def incomplete_achievements
    current_user.achievements.not_in_state(:dropped, :complete).with_courses.order("created_at DESC")
  end

  def completed_achievements
    current_user.achievements.in_state(:complete).with_courses.order("updated_at DESC")
  end

  def enrolments
    programmes = [
      Programme.primary_certificate,
      Programme.secondary_certificate,
      Programme.cs_accelerator,
      Programme.a_level,
      Programme.i_belong
    ]

    user_enrolments = current_user.enrolments.includes(:programme)

    enrolled = user_enrolments
      .select { |enrolment| enrolment.current_state != "unenrolled" }
      .map(&:programme)

    unenrolled = programmes.find_all { !enrolled.collect(&:id).include?(_1.id) }

    [enrolled, unenrolled]
  end
end
