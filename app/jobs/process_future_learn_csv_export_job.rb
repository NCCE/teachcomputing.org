class ProcessFutureLearnCsvExportJob < ApplicationJob
  queue_as :default

  def perform(csv_contents, import_record)
    csv = CSV.parse(csv_contents, headers: true)
    csv.each do |record|
      user = User.find_by('email ILIKE ?', record['learner_identifier'])
      activity = Activity.find_by(future_learn_course_id: record['course_uuid'])
      next if user.nil? || activity.nil?

      achievement = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end
      achievement.set_to_complete if record['steps_completed'].to_f >= 60
    end

    import_record.update(completed_at: DateTime.now.in_time_zone)
  end
end