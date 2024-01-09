require "rails_helper"

RSpec.describe SentEmail, type: :model do
  let(:sent_email) { create(:sent_email) }

  describe "associations" do
    it "belongs to user" do
      expect(sent_email).to belong_to(:user)
    end
  end

  describe "validations" do
    before do
      sent_email
    end

    it { is_expected.to validate_presence_of(:mailer_type) }
    it { is_expected.to validate_uniqueness_of(:user).case_insensitive.scoped_to(:mailer_type) }
  end
end
