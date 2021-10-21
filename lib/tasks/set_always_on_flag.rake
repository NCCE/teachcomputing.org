namespace :always_on_flag do
  task enable_group_1: :environment do
    %w[
      c9fb59cc-6393-4a29-8136-7020128ca879
      6c5bddfb-7dd4-467b-9554-34f3aedc233f
      ffc6793d-5643-40c8-893a-0164844ca62f
      04953102-a4cf-485d-a34e-0c64621033be
      3ce9a624-6cc7-4d23-8f5f-95162e360178
      e4115d3c-53d0-4538-94c2-e2a9ba366178
      645ec51f-0b46-4102-a364-90647057f4f2
      83c939cf-8aa7-43d9-ad06-acaa3b859d91
      26e9cd23-2d71-4964-9af3-751aa3fdc8e5
    ].each do |template_no|
      activity = Activity.find_by(future_learn_course_uuid: template_no)
      activity.update(always_on: true)
    end
  end
end
