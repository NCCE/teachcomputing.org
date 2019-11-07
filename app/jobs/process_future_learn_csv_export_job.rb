class ProcessFutureLearnCsvExportJob < ApplicationJob
  queue_as :default

  def perform(csv_contents, import_record)
    missing_courses = []
    csv = CSV.parse(csv_contents, headers: true)
    csv.each do |record|
      user = User.find_by('email ILIKE ?', record['learner_identifier'])
      begin
        activity = Activity.find_by!(future_learn_course_id: record['course_uuid'])
      rescue ActiveRecord::RecordNotFound
        unless missing_courses.include?(record['course_uuid'])
          Raven.capture_message("Missing course #{record['run_title']}: id #{record['course_uuid']} (user is: #{record['learner_identifier']})")
          missing_courses.push(record['course_uuid'])
        end
        next
      end
      next if user.nil?

      achievement = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end

      next if achievement.current_state == 'complete'

      if achievement.current_state == 'dropped'
        achievement.transition_to(:commenced) if record['left_at'].blank?
      end

      if record['steps_completed'].to_f >= 60
        achievement.set_to_complete
        if activity.programmes.include?(Programme.primary_certificate)
          PrimaryCertificatePendingTransitionJob.perform_later(user.id, source: 'ProcessFutureLearnCsvExportJob.perform')
        end
      end
      achievement.set_to_dropped(left_at: record['left_at']) if record['left_at'].present?
    end

    import_record.update(completed_at: DateTime.now.in_time_zone)
  end
end
