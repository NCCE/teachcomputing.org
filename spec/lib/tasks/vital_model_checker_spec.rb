require "rails_helper"

RSpec.describe "rake vital_model_checker", type: :task do
  before do
    allow(Sentry).to receive(:capture_message)
  end

  it "should call sentry if no Achievements" do
    task.execute
    expect(Sentry).to have_received(:capture_message).twice
  end
end
