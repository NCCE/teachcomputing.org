require "rails_helper"

RSpec.describe "achiever:get_course_info", type: :task do
  before do
    stub_age_groups
    stub_course_templates
    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects
  end

	it "updates certificate activity data" do 
    allow(Rails.logger).to receive(:warn).at_least(:once)
    task.execute
		expect(Rails.logger).to have_received(:warn).with('Getting current Achiever courses info')
	end 
end 