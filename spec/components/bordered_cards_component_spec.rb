require "rails_helper"

RSpec.describe BorderedCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: "support-cards",
      cards_per_row: 3,
      cards: [
        {
          class_name: "supporting-partners-card",
          title: I18n.t("pages.about.supporting_partners_card.title"),
          text: I18n.t("pages.about.supporting_partners_card.text"),
          link: {
            link_title: I18n.t("pages.about.supporting_partners_card.link_title"),
            link_url: "/supporting-partners"
          }
        },
        {
          class_name: "involvement-card",
          title: I18n.t("pages.about.involvement_card.title"),
          text: I18n.t("pages.about.involvement_card.text"),
          link: {
            link_title: I18n.t("pages.about.involvement_card.link_title"),
            link_url: "/get-involved"
          }
        },
        {
          class_name: "contributing-partners-card",
          title: I18n.t("pages.about.contributing_partners_card.title"),
          text: I18n.t("pages.about.contributing_partners_card.text"),
          link: {
            link_title: I18n.t("pages.about.contributing_partners_card.link_title"),
            link_url: "/contributing-partners"
          }
        },
        {
          class_name: "governors-card",
          title: I18n.t("pages.about.governors_card.title"),
          text: I18n.t("pages.about.governors_card.text"),
          link: {
            link_title: I18n.t("pages.about.governors_card.link_title"),
            link_url: "/governors-and-trustees/"
          }
        }
      ]
    }
  end

  context "without an image" do
    before do
      render_inline(described_class.new(**test_data))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".support-cards")
    end

    it "renders the expected number of cards" do
      expect(page).to have_css(".bordered-card", count: 4)
    end

    it "sets the expected properties" do
      expect(page).to have_xpath('//div[contains(@class, "support-cards")][contains(@style, "--cards-per-row: 3;")]')
    end

    it "does not render an image" do
      expect(page).not_to have_css("bordered-card__image-wrapper")
    end

    it "has the expected titles" do
      expect(page).to have_css(".supporting-partners-card", text: "Supporting partners")
      expect(page).to have_css(".involvement-card", text: "Get involved")
      expect(page).to have_css(".contributing-partners-card", text: "Contributing partners")
      expect(page).to have_css(".governors-card", text: "School governors")
    end

    it "has the expected body" do
      expect(page).to have_css(
        ".govuk-body", text: "Help us continue to remove barriers for teachers in state-funded education in England to access essential CPD."
      )
    end

    it "has the expected link" do
      expect(page).to have_link("Support us", href: "/supporting-partners")
    end
  end

  context "with an image" do
    before do
      test_data[:cards][0][:image_url] = "media/images/logos/isaac-logo-with-bg.svg"
      render_inline(described_class.new(**test_data))
    end

    it "renders an image" do
      expect(page).to have_css(".bordered-card__image-wrapper")
    end
  end
end
