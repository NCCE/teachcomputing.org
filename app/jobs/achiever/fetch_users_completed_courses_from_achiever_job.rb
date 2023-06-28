module Achiever
  class FetchUsersCompletedCoursesFromAchieverJob < ApplicationJob
    queue_as :default

    def perform(user)
      @assess_eligibility_job = false
      @pending_transition_job = false
      Achiever::Course::Delegate.find_by_achiever_contact_number(user.stem_achiever_contact_no).each do |course|
        activity = course_activity(stem_course_template_no: course.course_template_no, user_id: user.id)
        Rails.logger.warn "Could not find activity with template #{course.course_template_no} and occ #{course.course_occurence_no} for user #{user.stem_achiever_contact_no}" unless activity
        next unless activity

        achievement = fetch_achievement(activity_id: activity.id, user_id: user.id)
        next if achievement.current_state == 'complete'

        case course.attendance_status
        when 'attended'
          achievement.complete!

          determine_jobs_to_run(programme_slug: achievement.programme.slug) if achievement.programme
        when 'cancelled'
          achievement.drop!
        end
      end
      run_jobs(user.id)
    end

    private

      def course_activity(stem_course_template_no:, user_id:)
        Activity.find_by!(stem_course_template_no: stem_course_template_no)
      rescue ActiveRecord::RecordNotFound => e
        Sentry.set_tags(stem_course_template_no: stem_course_template_no, user_id: user_id)
        Sentry.capture_exception(e)
        nil
      end

      def fetch_achievement(activity_id:, user_id:)
        Achievement.find_or_create_by(activity_id: activity_id, user_id: user_id) do |achievement|
          achievement.activity_id = activity_id
          achievement.user_id = user_id
        end
      end

      def determine_jobs_to_run(programme_slug:)
        case programme_slug
        when 'cs-accelerator'
          @assess_eligibility_job = true
        when 'primary-certificate', 'secondary-certificate'
          @programme = Programme.find_by(slug: programme_slug)
          @pending_transition_job = true
        end
      end

      def run_jobs(user_id)
        AssessmentEligibilityJob.perform_later(user_id) if @assess_eligibility_job

        return unless @pending_transition_job

        CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(
          @programme,
          user_id,
          { source: 'FetchUsersCompletedCoursesFromAchieverJob' }
        )
      end
  end
end
