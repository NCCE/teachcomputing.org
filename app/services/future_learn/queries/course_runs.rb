module FutureLearn
  module Queries
    class CourseRuns
      ENDPOINT = '/partners/course_runs'.freeze

      def self.all
        FutureLearn::Request.run(ENDPOINT)
      end
    end
  end
end
