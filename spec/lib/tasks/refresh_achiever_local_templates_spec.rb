require 'rails_helper'

RSpec.describe "achiever:refresh_local_templates", type: :task do
  before do
    stub_age_groups
    stub_attendance_sets
    stub_duration_units
    stub_subjects
    stub_course_templates
    stub_course_listing
    stub_occurrence_details
  end
  
  it "refreshes course template data" do 
    allow(Rails.logger).to receive(:warn).at_least(:once)
    task.execute
    expect(Rails.logger).to have_received(:warn).with('Local course templates now refreshed')
  end 
  end 