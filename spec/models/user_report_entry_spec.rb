require "rails_helper"

RSpec.describe UserReportEntry, type: :model do
  describe "factory" do
    it "has a valid factory" do
      expect(build(:user_report_entry)).to be_valid
    end
  end
end
