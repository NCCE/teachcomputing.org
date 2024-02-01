require "rails_helper"

RSpec.describe Achiever::Course::Delegate do
  let(:delegate_records) { described_class.find_by_achiever_contact_number("id-101") }

  describe "accessor methods" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    it "provides the required accessor methods" do
      expect(delegate_records.first).to respond_to(:course_template_no)
      expect(delegate_records.first).to respond_to(:course_occurence_no)
      expect(delegate_records.first).to respond_to(:is_fully_attended)
      expect(delegate_records.first).to respond_to(:online_cpd)
      expect(delegate_records.first).to respond_to(:progress)
    end
  end

  describe "constants" do
    describe "RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Delegate::RESOURCE_PATH).not_to eq nil
      end
    end
  end

  describe "#attendance_status" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    context "when fully attended" do
      it "returns attended" do
        expect(delegate_records.first.attendance_status).to eq "attended"
      end
    end

    context "with a progress of cancelled" do
      it "returns cancelled" do
        expect(delegate_records[3].attendance_status).to eq "cancelled"
      end
    end
  end

  describe "class methods" do
    describe "#find_by_achiever_contact_number" do
      before do
        stub_delegate
      end

      it "returns an array" do
        expect(described_class.find_by_achiever_contact_number("id-101")).to be_an Array
      end

      it "contains instances of Achiever::Course::Delegate" do
        expect(described_class.find_by_achiever_contact_number("id-101").first).to be_an described_class
      end
    end
  end
end
