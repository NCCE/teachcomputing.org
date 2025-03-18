# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::MultiStateLinkComponent, type: :component do
  let(:user) { create(:user) }
  let!(:programme) { create(:i_belong) }

  context "with no logged in user" do
    before do
      render_inline(described_class.new(
        logged_out_link_title: "Log in",
        logged_out_link: "https://teachcomputing.org/login",
        not_enrolled_link_title: "Not enrolled",
        not_enrolled_link: "https://teachcomputing.org/not_enrolled",
        enrolled_link_title: "Enrolled",
        enrolled_link: "https://teachcomputing.org/enrolled",
        programme:
      ))
    end

    it "should render the logged out link and title" do
      expect(page).to have_link("Log in", href: "https://teachcomputing.org/login")
    end
  end

  context "with logged in user" do
    context "not enrolled" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        render_inline(described_class.new(
          logged_out_link_title: "Log in",
          logged_out_link: "https://teachcomputing.org/login",
          not_enrolled_link_title: "Not enrolled",
          not_enrolled_link: "https://teachcomputing.org/not_enrolled",
          enrolled_link_title: "Enrolled",
          enrolled_link: "https://teachcomputing.org/enrolled",
          programme:
        ))
      end

      it "should render the not enrolled link and title" do
        expect(page).to have_link("Not enrolled", href: "https://teachcomputing.org/not_enrolled")
      end
    end

    context "enrolled" do
      let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        render_inline(described_class.new(
          logged_out_link_title: "Log in",
          logged_out_link: "https://teachcomputing.org/login",
          not_enrolled_link_title: "Not enrolled",
          not_enrolled_link: "https://teachcomputing.org/not_enrolled",
          enrolled_link_title: "Enrolled",
          enrolled_link: "https://teachcomputing.org/enrolled",
          programme:
        ))
      end

      it "should render the enrolled link and title" do
        expect(page).to have_link("Enrolled", href: "https://teachcomputing.org/enrolled")
      end
    end
  end
end
