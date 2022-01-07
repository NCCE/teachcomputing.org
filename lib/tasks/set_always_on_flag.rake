namespace :always_on_flag do
  task enable: :environment do
    %w[
      0fbfa644-501d-4ac0-b3ef-3cc458d33527
      c88099c0-8b44-42a5-aad3-0dd011fe3490
      030261f8-1e96-4a70-a329-e3eb8b868915
      147b3adf-9f26-4ffa-a95f-6c1720ca4d27
      66ceead6-5641-485c-9d10-40a35b8e465e
      3574403e-a63f-4230-9f4b-3f5b6cd4ddb7
      2e1e3f69-b200-4fc7-a6bd-dff682bdd228
      88ad7443-d27a-482c-b2a9-83ddc1357532
      0adab04d-f1b5-4110-839d-76f9faf7b819
      7f88c178-9538-4970-b438-ab80e6125d5e
    ].each do |template_no|
      activity = Activity.find_by(future_learn_course_uuid: template_no)
      activity.update(always_on: true)
    end
  end
end
