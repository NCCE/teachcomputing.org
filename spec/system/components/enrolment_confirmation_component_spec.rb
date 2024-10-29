require "rails_helper"
require "axe/rspec"

RSpec.describe("Enrolment confirmation component system test", type: [:system, :component_sys_test]) do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  context "the programme requires enrolment confirmation" do
    before do
      with_rendered_component_path(render_inline(EnrolmentConfirmationComponent.new(
        current_user: user,
        programme: primary_certificate
      ))) do |path|
        visit(path)
      end
    end

    it "renders the certificate name" do
      expect(page).to have_text("Enrol on the #{primary_certificate.certificate_name}")
    end

    it "renders the ready to enrol text" do
      expect(page).to have_css("h2", text: "Ready to enrol?")
    end

    it "renders the enrolment confirmation text" do
      expect(page).to have_css("p", text: "Confirm your enrolment on the certificate, and then let's find you the perfect training course to get started with.")
    end

    it "has the enrolment confirmation button" do
      expect(page).to have_css("a", text: "Confirm my enrolment")
    end
  end

  context "the programme does not require enrolment confirmation" do
    before do
      with_rendered_component_path(render_inline(EnrolmentConfirmationComponent.new(
        current_user: user,
        programme: secondary_certificate
      ))) do |path|
        visit(path)
      end
    end

    it "renders the enrol button" do
      expect(page).to have_link(href: secondary_certificate.enrol_path(user_programme_enrolment: {user_id: user.id, programme_id: secondary_certificate.id}))
    end
  end
end
