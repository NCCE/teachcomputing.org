class FutureLearnCourseRunEnrolmentsJob < ApplicationJob
  queue_as :default

  def perform(course_uuid:, run_uuid:)
    # Do something later
  end
end
