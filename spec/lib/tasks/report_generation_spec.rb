require "rails_helper"

RSpec.describe "rake report_generation:generate_user_report", type: :task do
  it "should call ReportGeneration.generate_user_report" do
    expect(ReportGeneration).to receive(:generate_user_report)

    task.execute
  end
end
