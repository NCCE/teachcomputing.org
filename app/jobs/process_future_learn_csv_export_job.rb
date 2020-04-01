class ProcessFutureLearnCsvExportJob < ApplicationJob
  queue_as :default

  def perform(csv_contents, import_record)
    missing_courses = []
    csv = CSV.parse(csv_contents, headers: true)
    csv.each do |record|
      user = User.find_by('email ILIKE ?', record['learner_identifier'])
      begin
        activity = Activity.find_by!(future_learn_course_uuid: record['course_uuid'])
      rescue ActiveRecord::RecordNotFound
        unless missing_courses.include?(record['course_uuid'])
          Raven.capture_exception("Missing course #{record['run_title']}: id #{record['course_uuid']} (user is: #{record['learner_identifier']})")
          missing_courses.push(record['course_uuid'])
        end
        next
      end
      next if user.nil?

      achievement = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end

      next if achievement.current_state == :complete.to_s

      achievement.update_state_for_online_activity(record['steps_completed'].to_f, record['left_at'])

      next unless achievement.programme

      case achievement.programme.slug
      when 'cs-accelerator'
        AssessmentEligibilityJob.perform_later(achievement.user.id, source: 'AchievementsController.create')
      when 'primary-certificate'
        PrimaryCertificatePendingTransitionJob.perform_later(achievement.user.id, source: 'AchievementsController.create') if achievement.current_state == :complete.to_s
      end
    end

    import_record.update(completed_at: DateTime.now.in_time_zone)
  end
end
