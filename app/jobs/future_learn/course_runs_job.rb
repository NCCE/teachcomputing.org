module FutureLearn
  class CourseRunsJob < ApplicationJob
    queue_as :default

    def perform
      course_runs = FutureLearn::Queries::CourseRuns.all

      course_run_ids_hash = Hash.new { |h, k| h[k] = [] }
      course_runs.each { |r| course_run_ids_hash[r[:course][:uuid]] << r[:uuid] }

      tc_course_ids = Activity.all.pluck(:future_learn_course_uuid).compact

      course_run_ids_hash.each do |course_id, run_ids|
        unless tc_course_ids.include?(course_id)
          report_missing_course(course_id)
          next
        end

        FutureLearn::CourseEnrolmentsJob.perform_later(
          course_uuid: course_id,
          run_uuids: run_ids
        )
      end
    end

    private

      def report_missing_course(course_id)
        Raven.capture_message("FutureLearn course ID not be found during progress update checking: #{course_id}")
      end
  end
end
