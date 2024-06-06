require "rails_helper"

RSpec.describe SupportAudit, type: :model do
  let(:default_user) { create(:user, email: "admin@example.com") }
  let(:user) { create(:user) }
  let(:affected_user) { create(:user) }
  let(:authoriser) { create(:authoriser) }
  let(:support_audit) { build(:support_audit, user: nil, affected_user: nil, authoriser: authoriser) }

  describe "associations" do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to(:affected_user).class_name("User").with_foreign_key(:affected_user_id).optional }
    it { is_expected.to belong_to(:authoriser).optional }
  end

  describe "validations" do
    context "on update" do
      before { support_audit.save! }

      it "validates presence of authoriser_id" do
        expect(support_audit).to validate_presence_of(:authoriser_id).on(:update)
      end

      it "validates presence of comment" do
        expect(support_audit).to validate_presence_of(:comment).on(:update)
      end
    end
  end

  describe "callbacks" do
    before do
      allow(User).to receive(:find_by_email).and_return(default_user)
    end

    context "before_create" do
      it "adds actuating user details" do
        support_audit.save!
        expect(support_audit.user_id).to eq(default_user.id)
        expect(support_audit.username).to eq(default_user.email)
        expect(support_audit.user_type).to eq("teachcomputing")
      end

      it "adds affected user details" do
        support_audit.auditable = user
        support_audit.save!
        expect(support_audit.affected_user_id).to eq(user.id)
      end
    end
  end
end
