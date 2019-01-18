class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements
    
    @delegate_course_list = DelegateCourseList.fromAchiever(current_user.stem_achiever_contact_no)
      .select { |delegate_course| delegate_course.enrolment_status != 'Cancelled' && delegate_course.end_date < current_iso_date }

    render :show
  end

  private
  
  def current_iso_date
    Time.now.iso8601
  end
end
