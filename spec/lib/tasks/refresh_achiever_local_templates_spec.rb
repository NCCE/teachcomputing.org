require "rails_helper"

RSpec.describe "rake achiever:refresh_local_templates", type: :task do
  before do
    stub_age_groups
    stub_course_templates
    stub_attendance_sets
    stub_duration_units
    stub_subjects
    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_occurrence_details
    stub_delegate
    allow(STDOUT).to receive(:puts) # suppress puts
  end

  it "should attempt to create 9 local template files" do
    file = double
    allow(File).to receive(:new).and_return(file)
    expect(file).to receive(:write).exactly(9).times
    task.execute
  end
end
