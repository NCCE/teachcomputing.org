class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements
    t = Time.now
    current_date = t.iso8601
    @delegate_course_list = DelegateCourseList.fromAchiever(current_user.stem_achiever_contact_no)
      .select { |delegate_course| delegate_course.enrolment_status != 'Cancelled' && delegate_course.end_date < current_date }

    render :show
  end
end
