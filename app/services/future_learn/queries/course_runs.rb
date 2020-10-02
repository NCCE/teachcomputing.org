module FutureLearn
  module Queries
    class CourseRuns
      ENDPOINT = '/partners/course_runs'.freeze

      def self.all
        FutureLearn::Request.run(ENDPOINT)
      end

      def self.one(course_run_uuid)
        FutureLearn::Request.run(ENDPOINT, [course_run_uuid])
      end
    end
  end
end
