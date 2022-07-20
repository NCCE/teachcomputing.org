namespace :always_on_flag do
  task enable: :environment do
    %w[
      bc7debb8-59a0-4d4a-8d86-082047bf155f
      b2445d09-f3b3-45da-b4ec-6d33bb6cb89b
    ].each do |template_no|
      activity = Activity.find_by(future_learn_course_uuid: template_no)
      activity.update(always_on: true)
    end
  end
end
