require "rails_helper"

RSpec.describe Achiever::Course::Attendance do
  describe "constants" do
    describe "RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Attendance::RESOURCE_PATH).not_to eq nil
      end
    end

    describe "QUERY_STRINGS" do
      it "contains page" do
        expect(Achiever::Course::Attendance::QUERY_STRINGS).to have_key(:Page)
      end

      it "contains record count" do
        expect(Achiever::Course::Attendance::QUERY_STRINGS).to have_key(:RecordCount)
      end
    end
  end

  describe "class methods" do
    before do
      stub_attendance_sets
    end

    describe "#all" do
      it "returns a Hash" do
        stub_subjects
        expect(described_class.all).to be_an Hash
      end
    end
  end
end
