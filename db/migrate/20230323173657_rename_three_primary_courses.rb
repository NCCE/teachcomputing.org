class RenameThreePrimaryCourses < ActiveRecord::Migration[6.1]
  def up
    courses = [
      ["CP008", "Leading primary computing - module 1 - face to face"],
      ["CP456", "Leading primary computing - module 2 - remote"],
      ["CP005", "Primary computing for all - face to face"]
    ]
    update_course_titles(courses)
  end

  def down
    courses = [
      ["CP008", "Leading Primary Computing - Face to Face"],
      ["CP456", "Leading primary computing (remote)"],
      ["CP005", "Outstanding primary computing for all - face to face"]
    ]
    update_course_titles(courses)
  end

  private

  def update_course_titles(courses)
    courses.each do |course|
      Activity.find_by(stem_activity_code: course.first)&.update(title: course.second)
    end
  end
end
