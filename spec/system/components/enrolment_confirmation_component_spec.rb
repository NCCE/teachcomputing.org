require "rails_helper"
require "axe/rspec"

RSpec.describe("Enrolment confirmation component system test", type: [:system, :component_sys_test]) do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  context "when the programme requires enrolment confirmation" do
    before do
      with_rendered_component_path(render_inline(EnrolmentConfirmationComponent.new(
        current_user: user,
        programme: primary_certificate
      )), layout: "application") do |path|
        visit(path)
      end
    end

    it "lets you freely close the modal before confirming" do
      # click the edge of modal to close
      click_on "Enrol"
      expect(page).to have_selector(".ncce-modal--header h2", text: "Enrol on the Teach primary computing certificate")
      find(".ncce-modal--body").click(x: 0, y: 200)

      # press ESC to close
      click_on "Enrol"
      expect(page).to have_selector(".ncce-modal--header h2", text: "Enrol on the Teach primary computing certificate")
      send_keys :escape
      expect(page).to have_no_selector(".ncce-modal--body")

      # press the X icon to close
      click_on "Enrol"
      expect(page).to have_selector(".ncce-modal--header h2", text: "Enrol on the Teach primary computing certificate")
      find(".icon-close").click
      expect(page).to have_no_selector(".ncce-modal--body")
    end
  end
end
