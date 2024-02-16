require "rails_helper"

RSpec.describe("pages/primary-senior-leaders") do
  # TODO: can we read values from /app/config/locales/views/pages/primary-senior-leaders/en.yml ?
  let(:hero_title) { I18n.t("pages.primary-senior-leaders.hero.title") }
  let(:confidence_title) { I18n.t("pages.primary-senior-leaders.objectives.cards.confidence.title") }
  let(:teach_primary_title) { I18n.t("pages.primary-senior-leaders.objectives.cards.teach-primary.title") }
  let(:download_brochure_title) { I18n.t("pages.primary-senior-leaders.objectives.cards.download-brochure.title") }

  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css("h1", text: hero_title)
  end

  it "has the IconRowComponent" do
    expect(rendered).to have_css(".icon-row-component-icon_content", text: "Curriculum design")
  end

  it "has the BorderedCardsComponent" do
    expect(rendered).to have_css(".resources-help-cards")
  end

  it "has the ambassador banner" do
    expect(rendered).to have_css(".inspire-with-comp-ambassador-banner")
  end

  it "has the objectives listed" do
    expect(rendered).to have_css(".non-bordered-card__title", text: confidence_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: teach_primary_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: download_brochure_title)
  end
end
