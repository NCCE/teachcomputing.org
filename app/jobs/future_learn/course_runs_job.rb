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
          title = course_runs.select { |r| r[:course][:uuid] == course_id }.first[:title]
          report_missing_course(course_id, title)
          next
        end

        FutureLearn::CourseEnrolmentsJob.perform_later(
          course_uuid: course_id,
          run_uuids: run_ids
        )
      end
    end

    private

      def report_missing_course(course_id, title)
        Raven.capture_message("FutureLearn course not found during progress update checking: #{course_id}, - #{title}")
      end
  end
end
