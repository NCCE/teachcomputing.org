require "rails_helper"

RSpec.describe ScheduleIBelongStudentSurveyPromptJob, type: :job do
  let(:user) { create(:user) }

  it "should send email" do
    expect {
      described_class.perform_now(user)
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
