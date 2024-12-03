class AddCourseVideoUrlToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :course_video_url, :string
  end
end
