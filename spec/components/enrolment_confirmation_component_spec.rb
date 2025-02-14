require "rails_helper"

RSpec.describe EnrolmentConfirmationComponent, type: :component do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:pathway) { create(:pathway) }

  context "when no current user" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        programme: primary_certificate,
        pathway: nil
      ))
    end

    it "does not render the modal" do
      expect(page).to_not have_css(".ncce-modal")
    end

    it "renders a log in button" do
      expect(page).to have_link("Log in", href: "/auth/stem")
    end
  end

  context "when enrolment confirmation is false on the programme" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render_inline(described_class.new(
        programme: cs_accelerator,
        pathway:
      ))
    end

    it "does not render the modal" do
      expect(page).to_not have_css(".ncce-modal")
    end

    it "has an programme enrolment button" do
      expect(page).to have_link("Enrol", href: cs_accelerator.enrol_path(user_programme_enrolment: {user_id: user.id, programme_id: cs_accelerator.id, pathway_slug: pathway.slug}))
    end
  end

  context "when the enrolment comfirmation is true on the programme" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render_inline(described_class.new(
        programme: primary_certificate,
        pathway:
      ))
    end

    it "renders the modal" do
      expect(page).to have_css(".ncce-modal")
    end

    it "renders the enrol button" do
      expect(page).to have_css("button", text: "Enrol")
    end

    it "renders the enrollment confimation button" do
      expect(page).to have_link("Confirm my enrolment", href: primary_certificate.enrol_path(user_programme_enrolment: {user_id: user.id, programme_id: primary_certificate.id, pathway_slug: pathway.slug}))
    end
  end

  context "with button text and full width to false" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render_inline(described_class.new(
        programme: primary_certificate,
        button_text: "Click here to enrol",
        full_width: false,
        pathway:
      ))
    end

    it "renders the modal" do
      expect(page).to have_css(".ncce-modal")
    end

    it "renders the button text" do
      expect(page).to have_button("Click here to enrol")
    end

    it "does not apply the full width button classes" do
      expect(page).to_not have_css(".enrolment-confirmation-component__button--full-width")
    end
  end

  context "when no current user and logged out button text" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        programme: cs_accelerator,
        logged_out_button_text: "Log in to enrol"
      ))
    end

    it "renders a log in button" do
      expect(page).to have_link("Log in to enrol", href: "/auth/stem")
    end
  end

  context "when the user is already enrolled on a non confirmation programme" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow(cs_accelerator).to receive(:user_enrolled?).with(user).and_return(true)

      render_inline(described_class.new(
        programme: cs_accelerator,
        pathway:
      ))
    end

    it "does not render the modal" do
      expect(page).to_not have_css(".ncce-modal")
    end

    it "renders the view dashboard button" do
      expect(page).to have_link("Visit dashboard", href: "/certificate/subject-knowledge")
    end
  end

  context "when the user is already enrolled on a programme that requires confirmation" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

      render_inline(described_class.new(
        programme: primary_certificate,
        pathway:
      ))
    end

    it "does not render the modal" do
      expect(page).to_not have_css(".ncce-modal")
    end

    it "renders the view dashboard button" do
      expect(page).to have_link("Visit dashboard", href: "/certificate/primary-certificate")
    end
  end
end
