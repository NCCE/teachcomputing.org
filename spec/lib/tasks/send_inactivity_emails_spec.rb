require "rails_helper"

RSpec.describe "rake inactivity_emails:send", type: :task do
  it "should call SendInactivityEmailsJob.perform_now" do
    expect(SendInactivityEmailsJob).to receive(:perform_now)

    task.execute
  end
end
