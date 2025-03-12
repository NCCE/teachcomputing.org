# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::IBelongPictureCardComponent, type: :component do
  let(:user) { create(:user) }
  let!(:programme) { create(:i_belong) }
  let(:card_links) {
    {
      enrolled: {
        link: "https://teachcomputing.org/enrolled",
        title: "Enrolled"
      },
      not_enrolled: {
        link: "https://teachcomputing.org/not-enrolled",
        title: "Not enrolled"
      },
      logged_out: {
        link: "https://teachcomputing.org/login",
        title: "Log in"
      }
    }
  }

  context "with no logged in user" do
    before do
      render_inline(described_class.new(
        title: "Card title",
        text_content: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model,
        card_links:
      ))
    end

    it "renders the card title" do
      expect(page).to have_text("Card title")
    end

    it "renders the rich text component" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders the image" do
      expect(page).to have_css("img")
    end

    it "renders the logged out link and title" do
      expect(page).to have_link("Log in", href: "https://teachcomputing.org/login")
    end
  end

  context "with logged in user" do
    context "not enrolled" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        render_inline(described_class.new(
          title: "Card title",
          text_content: Cms::Mocks::RichBlocks.as_model,
          image: Cms::Mocks::Image.as_model,
          card_links:
        ))
      end

      it "renders the not enrolled link and title" do
        expect(page).to have_link("Not enrolled", href: "https://teachcomputing.org/not-enrolled")
      end
    end

    context "when enrolled" do
      let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        render_inline(described_class.new(
          title: "Card title",
          text_content: Cms::Mocks::RichBlocks.as_model,
          image: Cms::Mocks::Image.as_model,
          card_links:
        ))
      end

      it "renders the enrolled link and title" do
        expect(page).to have_link("Enrolled", href: "https://teachcomputing.org/enrolled")
      end
    end
  end
end
