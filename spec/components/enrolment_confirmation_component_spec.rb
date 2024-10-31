require "rails_helper"

RSpec.describe EnrolmentConfirmationComponent, type: :component do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:cs_accelerator) { create(:cs_accelerator) }

  context "when no current user" do
    before do
      render_inline(described_class.new(
        programme: primary_certificate,
        current_user: nil
      ))
    end

    it "renders a log in button" do
      expect(page).to have_text("Log in")
    end
  end

  context "when enrolment confirmation is false on the programme" do
    before do
      render_inline(described_class.new(
        programme: cs_accelerator,
        current_user: user
      ))
    end

    it "does not render the modal and enrols the user" do
      expect(page).to have_link(href: cs_accelerator.enrol_path(user_programme_enrolment: {user_id: user.id, programme_id: cs_accelerator.id}))
    end
  end

  context "when the enrolment comfirmation is true on the programme" do
    before do
      render_inline(described_class.new(
        programme: primary_certificate,
        current_user: user
      ))
    end

    it "renders the modal button" do
      expect(page).to have_css("button", text: "Enrol")
    end
  end

  context "with button text and full width to false" do
    before do
      render_inline(described_class.new(
        programme: primary_certificate,
        current_user: user,
        button_text: "Click here to enrol",
        full_width: false
      ))
    end

    it "renders the button text" do
      expect(page).to have_text("Click here to enrol")
    end

    it "does not apply the full width button classes" do
      expect(page).to_not have_css(".enrolment-confirmation-component__button--full-width")
    end
  end

  context "when the user is already enrolled on a non confirmation programme" do
    before do
      allow(cs_accelerator).to receive(:user_enrolled?).with(user).and_return(true)

      render_inline(described_class.new(
        programme: cs_accelerator,
        current_user: user
      ))
    end

    it "renders the view dashboard button" do
      expect(page).to have_text("Visit dashboard")
    end
  end

  context "when the user is already enrolled on a programme that requires confirmation" do
    before do
      allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

      render_inline(described_class.new(
        programme: primary_certificate,
        current_user: user
      ))
    end

    it "renders the view dashboard button" do
      expect(page).to have_text("Visit dashboard")
    end
  end
end
