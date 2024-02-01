require "rails_helper"

RSpec.describe Achiever::UpdateUsersDetailsFromAchieverJob do
  let(:user) { create(:user, stem_achiever_contact_no: "ca432eb9-9b34-46db-afbb-fbd1efa89e6b") }
  let(:user_invalid) { create(:user, stem_achiever_contact_no: "ca432eb9-9b34-46db-afbb-fbd1efa89e6c", stem_achiever_organisation_no: "abc") }
  let(:user_no_org) { create(:user, stem_achiever_contact_no: "ca432eb9-9b34-46db-afbb-fbd1efa89e6c") }

  before do
    stub_valid_contact_details
    stub_invalid_contact_details
    stub_contact_no_org_details
  end

  after do
    clear_enqueued_jobs
  end

  describe "#perform" do
    include ActiveJob::TestHelper

    context "when a matching user exists" do
      it "updates the users org details" do
        expect do
          described_class.perform_now(user)
        end.to change(user, :stem_achiever_organisation_no).from(nil).to("company-no")
      end
    end

    context "when a user doesn't exist" do
      it "does not change the users org details" do
        expect do
          described_class.perform_now(user_invalid)
        end.not_to change(user_invalid, :stem_achiever_organisation_no).from("abc")
      end
    end

    context "when a user doesn't have an org" do
      it "does not change the users org details" do
        expect do
          described_class.perform_now(user_no_org)
        end.not_to change(user_no_org, :stem_achiever_organisation_no)
      end
    end
  end
end
