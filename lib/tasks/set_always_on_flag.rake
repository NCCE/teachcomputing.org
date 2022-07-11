namespace :always_on_flag do
  task enable: :environment do
    %w[
      2d32d88c-35a7-ea11-a812-000d3a86d545
    ].each do |template_no|
      activity = Activity.find_by(future_learn_course_uuid: template_no)
      activity.update(always_on: true)
    end
  end
end
