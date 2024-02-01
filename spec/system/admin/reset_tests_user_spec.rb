require "rails_helper"

RSpec.describe "User reset tests" do
  before do
    ENV["BYPASS_ADMINISTRATE_CF_AUTH"] = "true"
  end

  after do
    ENV["BYPASS_ADMINISTRATE_CF_AUTH"] = "false"
  end

  context "with assessment attempts" do
    let(:user) { create(:user, email: ENV.fetch("DEFAULT_ADMIN_EMAIL")) }
    let!(:attempts) { create_list(:assessment_attempt, 5, user:) }

    it "allows resetting assessment tests for a user" do
      click_remove_attempts
      expect(user.assessment_attempts.count).to eq(0)
    end

    it "provides an audit record of the reset" do
      expect { click_remove_attempts }.to change { SupportAudit.all.count }.by(attempts.count)
    end

    def click_remove_attempts
      visit admin_users_path(user.id)
      click_link user.email
      click_link "Remove Assessment Attempts"
      expect(page).to have_text("Edit SupportAudit")
    end
  end
end
