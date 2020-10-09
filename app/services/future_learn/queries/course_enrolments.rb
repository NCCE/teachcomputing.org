module FutureLearn
  module Queries
    class CourseEnrolments

      def self.all(run_uuid)
        FutureLearn::Request.run("/partners/course_runs/#{run_uuid}/course_enrolments_report")
      end
    end
  end
end
