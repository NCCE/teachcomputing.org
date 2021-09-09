task remove_activities_from_programmes: :environment do
  desc 'Removes the specified activities from programmes'
  %w[
    7d7044f3-c4ea-eb11-bacb-0022481a7a8c
    b41096d2-c8ea-eb11-bacb-0022481a422d
    c9409a58-0b07-ec11-b6e6-000d3a86d86c
    9dbd1486-0f07-ec11-b6e6-000d3a86d86c
    0b5c8499-1307-ec11-b6e6-000d3a86d86c
  ].each do |template_no|
    activity = Activity.find_by(stem_course_template_no: template_no)
    ProgrammeActivity.find_by(activity_id: activity.id).destroy
  end
end
