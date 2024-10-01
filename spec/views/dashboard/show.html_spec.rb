require "rails_helper"

RSpec.describe("dashboard/show", type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let!(:online_activity) { create(:activity, :my_learning) }
  let!(:remote_activity) { create(:activity, :remote) }
  let!(:face_to_face) { create(:activity, :stem_learning) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:i_belong) { create(:i_belong) }
  let!(:a_level) { create(:a_level) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: cs_accelerator.id)
  end

  context "when the user has not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = []
      @unenrolled_certificates = [
        primary_certificate,
        secondary_certificate,
        cs_accelerator,
        i_belong,
        a_level
      ]
      @user_achievements = []
      render
    end

    it "has a title" do
      expect(rendered).to have_css("h1", text: "Progress overview")
    end

    it "has enrolled certificates title" do
      expect(rendered).to have_css("h1", text: "Enrolled certificates")
    end

    it "has other certificates title" do
      expect(rendered).to have_css("h1", text: "Other certificates")
    end

    it "has five certificates" do
      expect(rendered).to have_css(".dashboard-certificate", count: 5)
    end

    it "shows the certificates as unenrolled" do
      expect(rendered).to have_text("Find out more", count: 5)
    end
  end

  context "when the user has enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = [
        primary_certificate,
        secondary_certificate
      ]
      @unenrolled_certificates = [
        cs_accelerator,
        i_belong,
        a_level
      ]
      @user_achievements = []
      render
    end

    it "has five certificates" do
      expect(rendered).to have_css(".dashboard-certificate", count: 5)
    end

    it "shows two certificates as enrolled" do
      expect(rendered).to have_text("Check my progress", count: 2)
    end

    it "shows three certificates as unenrolled" do
      expect(rendered).to have_text("Find out more", count: 3)
    end
  end

  context "when the user has achievements" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = []
      @unenrolled_certificates = []

      @user_achievements = create_list(:achievement, 2, activity: face_to_face)
      render
    end

    it "renders the two courses" do
      expect(rendered).to have_css(".dashboard-course-component", count: 2)
    end
  end
end
