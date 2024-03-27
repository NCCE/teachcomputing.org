require "rails_helper"

RSpec.describe Achiever::User::Enrolment do
  let(:enrolment) { create(:user_programme_enrolment) }
  let(:achiever_user_enrolment) { described_class.new(enrolment) }

  describe "constants" do
    describe "RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::User::Enrolment::RESOURCE_PATH).not_to eq nil
      end
    end
  end

  describe "class methods" do
    describe "#send" do
      before do
        stub_post_enrolment
      end

      it "returns an OpenStruct" do
        expect(achiever_user_enrolment.sync).to be_an OpenStruct
      end
    end
  end
end
