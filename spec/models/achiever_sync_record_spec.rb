require "rails_helper"

RSpec.describe AchieverSyncRecord, type: :model do
  let(:achiever_sync_record) { create(:achiever_sync_record) }

  describe "associations" do
    it "belongs_to assessment" do
      expect(achiever_sync_record).to belong_to(:user_programme_enrolment)
    end

    it "only accepts valid states" do
      %w[enrolled pending complete unenrolled].each do |state|
        expect(build(:achiever_sync_record, state: state).valid?).to eq true
      end
    end

    it "wont accept non valid states" do
      expect(build(:achiever_sync_record, state: "published").valid?).to eq false
    end
  end

  describe "validations" do
    before do
      achiever_sync_record
    end

    it "does not create a record if it already exists with the given state" do
      new_record = build(:achiever_sync_record,
        user_programme_enrolment_id: achiever_sync_record.user_programme_enrolment_id, state: "enrolled")
      expect(new_record.valid?).to eq false
    end
  end
end
