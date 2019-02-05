class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements

    @delegate_course_list = DelegateCourseList.from_achiever(current_user.stem_achiever_contact_no)
                                              .select { |delegate_course| delegate_course.delegate_is_fully_attended == '1' }

    render :show
  end
end
