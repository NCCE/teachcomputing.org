require "rails_helper"

RSpec.describe("dashboard/show", type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
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
  let(:completed_programme_enrolment) do
    create(:completed_enrolment,
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
      @incomplete_achievements = []
      @completed_achievements = []
      render
    end

    it "has a page title" do
      expect(rendered).to have_text("Progress overview")
    end

    it "has no enrolled certificate section title" do
      expect(rendered).to_not have_text("Enrolled certificates")
    end

    it "has choose your next certificate title" do
      expect(rendered).to have_text("Choose your certificate")
    end

    it "renders five certificate components" do
      expect(rendered).to have_css(".dashboard-certificate", count: 5)
    end

    it "shows the certificates as unenrolled" do
      expect(rendered).to have_text("Find out more", count: 5)
    end
  end

  context "when the user has enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user_programme_enrolment
      user.reload

      @enrolled_certificates = [cs_accelerator]
      @unenrolled_certificates = [
        primary_certificate,
        secondary_certificate,
        i_belong,
        a_level
      ]

      @incomplete_achievements = []
      @completed_achievements = []
      render
    end

    it "renders five certificate components" do
      expect(rendered).to have_css(".dashboard-certificate", count: 5)
    end

    it "has one enrolled certificate" do
      expect(rendered).to have_text("Check my progress", count: 1)
    end

    it "shows four certificates as unenrolled" do
      expect(rendered).to have_text("Find out more", count: 4)
    end

    it "has enrolled certificates title" do
      expect(rendered).to have_text("Enrolled certificates")
    end

    it "has choose your next certificate title" do
      expect(rendered).to have_text("Choose your next certificate")
    end
  end

  context "when the user has completed a certificate" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:user_meets_completion_requirement?).with(user).and_return(true)

      completed_programme_enrolment
      user.reload

      @enrolled_certificates = [cs_accelerator]
      @unenrolled_certificates = [
        primary_certificate,
        secondary_certificate,
        i_belong,
        a_level
      ]

      @incomplete_achievements = []
      @completed_achievements = []
      render
    end

    it "has one completed certificate" do
      expect(rendered).to have_text("Download my certificate", count: 1)
    end
  end

  context "when the user has incomplete achievements" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = []
      @unenrolled_certificates = []

      @incomplete_achievements = create_list(:in_progress_achievement, 2, user: user)
      @completed_achievements = []
      user.reload
      render
    end

    it "has the section title" do
      expect(rendered).to have_text("Your courses")
    end

    it "renders course components" do
      expect(rendered).to have_css(".dashboard-course-component", count: 2)
    end
  end

  context "when the user has a completed achievement" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = []
      @unenrolled_certificates = []

      @incomplete_achievements = []
      @completed_achievements = [create(:completed_achievement, user: user, activity: face_to_face)]
      user.reload
      render
    end

    it "has the completed courses title" do
      expect(rendered).to have_text("Completed courses")
    end

    it "renders one course component" do
      expect(rendered).to have_css(".dashboard-course-component", count: 1)
    end
  end

  context "when the user has both completed and incomplete courses" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      @enrolled_certificates = []
      @unenrolled_certificates = []

      @incomplete_achievements = create_list(:in_progress_achievement, 2, user: user)
      @completed_achievements = create_list(:completed_achievement, 2, user: user)
      user.reload
      render
    end

    it "has the completed courses title" do
      expect(rendered).to have_text("Completed courses")
    end

    it "renders four course components" do
      expect(rendered).to have_css(".dashboard-course-component", count: 4)
    end
  end
end
