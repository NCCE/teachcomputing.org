class FetchUsersCompletedCoursesFromAchieverJob < ApplicationJob
  queue_as :default

  def perform(user)
    courses = DelegateCourseList.from_achiever(user.stem_achiever_contact_no)
    courses.each do |course|
      begin
        activity = Activity.find_by!(course_id: course.course_template_no)
      rescue ActiveRecord::RecordNotFound => e
        Raven.tags_context(course_id: course.course_template_no, user_id: user.id)
        Raven.capture_exception(e)
        next
      end
      achievement = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end
      achievement.set_to_complete if course.delegate_is_fully_attended == '1'
    end
  end
end
