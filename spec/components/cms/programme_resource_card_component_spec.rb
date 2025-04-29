# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::ProgrammeResourceCardComponent, type: :component do
  let(:user) { create(:user) }
  let!(:programme) { create(:i_belong) }

  context "when no logged in user" do
    let(:logged_out_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:not_enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }

    before do
      render_inline(described_class.new(
        title: "Card title",
        logged_out_text_content:,
        enrolled_text_content:,
        not_enrolled_text_content:,
        programme:
      ))
    end

    it "renders the title" do
      expect(page).to have_css(".govuk-heading-m", text: "Card title")
    end

    it "does not render a button" do
      expect(page).to_not have_css("govuk-button")
    end

    it "renders the logged out text" do
      expect(page).to have_text(logged_out_text_content.blocks.dig(0, :children, 0, :text))
    end
  end

  context "when not enrolled user" do
    let(:logged_out_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:not_enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }

    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      render_inline(described_class.new(
        title: "Card title",
        logged_out_text_content:,
        enrolled_text_content:,
        not_enrolled_text_content:,
        programme:
      ))
    end

    it "renders the not enrolled text" do
      expect(page).to have_text(not_enrolled_text_content.blocks.dig(0, :children, 0, :text))
    end
  end

  context "when enrolled user" do
    let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }
    let(:logged_out_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:not_enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }

    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      render_inline(described_class.new(
        title: "Card title",
        logged_out_text_content:,
        enrolled_text_content:,
        not_enrolled_text_content:,
        programme: programme
      ))
    end

    it "renders the enrolled text" do
      expect(page).to have_text(enrolled_text_content.blocks.dig(0, :children, 0, :text))
    end
  end

  context "with button" do
    let(:logged_out_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:not_enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:button) {
      Cms::Models::DynamicComponents::Buttons::EnrolButton.new(
        logged_out_button_text: "Logged out",
        logged_in_button_text: "Logged in",
        programme_slug: "i-belong"
      )
    }

    context "when logged out user" do
      before do
        render_inline(described_class.new(
          title: "Card title",
          logged_out_text_content:,
          enrolled_text_content:,
          not_enrolled_text_content:,
          programme:,
          button:
        ))
      end

      it "renders the logged out button" do
        expect(page).to have_css(".govuk-button", text: "Logged out")
      end
    end

    context "when user logged in user" do
      context "not enrolled" do
        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

          render_inline(described_class.new(
            title: "Card title",
            logged_out_text_content:,
            enrolled_text_content:,
            not_enrolled_text_content:,
            programme:,
            button:
          ))
        end

        it "renders the logged in button" do
          expect(page).to have_css(".govuk-button", text: "Logged in")
        end
      end

      context "when enrolled" do
        let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

          render_inline(described_class.new(
            title: "Card title",
            logged_out_text_content:,
            enrolled_text_content:,
            not_enrolled_text_content:,
            programme:,
            button:
          ))
        end

        it "renders the enrolled button" do
          expect(page).to have_css(".govuk-button", text: "Visit dashboard")
        end
      end
    end
  end

  context "with color theme" do
    let(:logged_out_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }
    let(:not_enrolled_text_content) { Cms::Mocks::Text::RichBlocks.as_model }

    before do
      render_inline(described_class.new(
        title: "Card title",
        logged_out_text_content:,
        enrolled_text_content:,
        not_enrolled_text_content:,
        programme: programme,
        color_theme: "i-belong"
      ))
    end

    it "has the cms color theme class" do
      expect(page).to have_css(".cms-color-theme__border--i-belong-top")
    end
  end
end
