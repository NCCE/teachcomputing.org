module FutureLearn
  class UpdateUserActivityJob < ApplicationJob
    queue_as :default

    def perform(course_uuid:, enrolment:); end
  end
end
