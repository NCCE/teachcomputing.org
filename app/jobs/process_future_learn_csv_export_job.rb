class ProcessFutureLearnCsvExportJob < ApplicationJob
  queue_as :default

  def perform(activity, csv_contents, import_record)
    csv = CSV.parse(csv_contents, headers: true)
    csv.each do |record|
      user = User.find_by(email: record['learner_identifier'])
      next if user.nil? || record['steps_completed'].to_f < 60

      Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end
    end

    import_record.update(completed_at: DateTime.now.in_time_zone)
  end
end
