require "rails_helper"

RSpec.describe("dashboard/certificates/_secondary", type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:secondary_certificate) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end

  before do
    programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  context "when the user has not enrolled on Secondary programme" do
    it "the link to find out more" do
      render template: "dashboard/certificates/_secondary", locals: {programme: programme}
      expect(rendered).to have_link("Choose a pathway", href: secondary_path)
    end
  end

  context "when the user has enrolled onto the Secondary programme" do
    it "shows the check progress link" do
      user_programme_enrolment
      render template: "dashboard/certificates/_secondary", locals: {programme: programme}
      expect(rendered).to have_link("Check progress", href: programme.path)
    end
  end

  context "when the user has completed the Secondary programme" do
    it "shows the certificate link" do
      allow_any_instance_of(Programmes::SecondaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
      user_programme_enrolment.transition_to(:complete)
      render template: "dashboard/certificates/_secondary", locals: {programme: programme}
      expect(rendered).to have_link("View certificate", href: programme.path)
    end
  end
end
