require "rails_helper"

RSpec.describe("pages/secondary-senior-leaders") do
  let(:hero_title) { I18n.t("pages.secondary-senior-leaders.hero.title") }
  let(:invest_title) { I18n.t("pages.secondary-senior-leaders.objectives.cards.invest.title") }
  let(:certification_title) { I18n.t("pages.secondary-senior-leaders.objectives.cards.certification.title") }
  let(:download_brochure_title) { I18n.t("pages.secondary-senior-leaders.objectives.cards.download-brochure.title") }

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

  it "has i belong banner" do
    expect(rendered).to have_css(".i-belong-banner")
  end

  it "has the ambassador banner" do
    expect(rendered).to have_css(".inspire-with-comp-ambassador-banner")
  end

  it "has the objectives listed" do
    expect(rendered).to have_css(".non-bordered-card__title", text: invest_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: certification_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: download_brochure_title)
  end
end
