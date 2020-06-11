class ProcessFutureLearnCsvExportJob < ApplicationJob
  queue_as :default

  def perform(csv_contents, import_record)
    @missing_courses = []
    @cs_accelerator_user_ids = []
    @primary_certificate_user_ids = []

    CSV.parse(csv_contents, headers: true).each do |record|
      user = User.find_by('email ILIKE ?', record['learner_identifier'])
      next if user.nil?

      activity = fetch_activity(record)
      next if activity.nil?

      achievement = fetch_achievement(activity_id: activity.id, user_id: user.id)
      next if achievement.complete?

      achievement.update_state_for_online_activity(record['steps_completed'].to_f, record['left_at'])

      next if achievement.programme.nil?

      determine_jobs_to_run(achievement: achievement, user_id: user.id)
    end

    queue_jobs_for_users

    import_record.update(completed_at: DateTime.now.in_time_zone)
  end

  private

    def fetch_activity(record)
      Activity.find_by!(future_learn_course_uuid: record['course_uuid'])
    rescue ActiveRecord::RecordNotFound
      unless @missing_courses.include?(record['course_uuid'])
        Raven.capture_exception("Missing course #{record['run_title']}: id #{record['course_uuid']} (user is: #{record['learner_identifier']})")
        @missing_courses.push(record['course_uuid'])
      end
      nil
    end

    def fetch_achievement(activity_id:, user_id:)
      Achievement.find_or_create_by(activity_id: activity_id, user_id: user_id) do |achievement|
        achievement.activity_id = activity_id
        achievement.user_id = user_id
      end
    end

    def determine_jobs_to_run(achievement:, user_id:)
      case achievement.programme.slug
      when 'cs-accelerator'
        @cs_accelerator_user_ids << user_id
      when 'primary-certificate'
        @primary_certificate_user_ids << user_id if achievement.current_state == :complete.to_s
      end
    end

    def queue_jobs_for_users
      @cs_accelerator_user_ids.uniq.each do |id|
        AssessmentEligibilityJob.perform_later(id)
      end

      @primary_certificate_user_ids.uniq.each do |id|
        PrimaryCertificatePendingTransitionJob.perform_later(id, source: 'AchievementsController.create')
      end
    end
end
