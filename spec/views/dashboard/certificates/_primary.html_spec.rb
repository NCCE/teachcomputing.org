require "rails_helper"

RSpec.describe("dashboard/certificates/_primary", type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:programme) { create(:primary_certificate) }
  let(:programmes) { Programme.enrollable }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id) }

  before do
    programme_activity
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    @achievements = user.achievements
    render template: "dashboard/certificates/_primary", locals: {programme: programme}
  end

  context "when the user has enrolled onto the Primary programme" do
    before do
      user_programme_enrolment
      user.reload
      render template: "dashboard/certificates/_primary", locals: {programme: programme}
    end

    it "shows the certificate link" do
      expect(rendered).to have_link("Teach primary computing", href: primary_certificate_path)
    end
  end

  context "when the user has completed the Primary programme" do
    before do
      user_programme_enrolment.transition_to(:pending)
      user.reload
      render template: "dashboard/certificates/_primary", locals: {programme: programme}
    end

    it "shows the completed text" do
      expect(rendered).to have_css(".status-block-light", text: "Programme complete")
    end
  end

  context "when the user has been awarded the Primary certificate" do
    before do
      user_programme_enrolment.transition_to(:complete)
      user.reload
      render template: "dashboard/certificates/_primary", locals: {programme: programme}
    end

    it "shows the completed text" do
      expect(rendered).to have_css(".status-block-light", text: "Certificate awarded")
    end
  end
end
