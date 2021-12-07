namespace :always_on_flag do
  task enable_group_1: :environment do
    %w[
      8a38adaf-9a03-414a-ad9f-c0b5a9f347f1
      d440d652-4128-4995-9ef7-662a0bc505ed
      b19646a7-d78b-4a92-ad36-d4b3a11a3df1
      6cd40c14-adbf-4da7-af81-849d0f74a2fe
      d9fe6126-298f-48ed-8be3-b82e1c473566
      ceb5e1b6-6f1d-4e53-9cd3-3fddb2509fa8
      a1520b0c-8c99-49e5-8c65-f025f3431ab0
      e290318f-ba23-4c95-8f18-584946233af9
      ecf78d20-2966-4798-af5f-0f869c1818e2
      3ce9a624-6cc7-4d23-8f5f-95162e360178
    ].each do |template_no|
      activity = Activity.find_by(future_learn_course_uuid: template_no)
      activity.update(always_on: true)
    end
  end
end
