class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @incomplete_achievements = current_user.achievements.not_in_state(:dropped, :complete)
                                           .with_courses.order('created_at DESC')
    @completed_achievements = current_user.achievements.in_state(:complete)
                                          .with_courses.order('updated_at DESC')

    user_courses = Achiever::Course::Delegate.find_by_achiever_contact_number(current_user.stem_achiever_contact_no)
    @user_courses = user_courses.select { |course| %w[enrolled attended].include?(course.attendance_status) }

    render :show
  end
end
