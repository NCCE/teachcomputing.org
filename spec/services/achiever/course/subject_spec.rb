require "rails_helper"

RSpec.describe Achiever::Course::Subject do
  describe "constants" do
    describe "RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Subject::RESOURCE_PATH).not_to eq nil
      end
    end
  end

  describe "class methods" do
    describe "#all" do
      it "returns a Hash" do
        stub_subjects
        expect(described_class.all).to be_an Hash
      end
    end
  end
end
