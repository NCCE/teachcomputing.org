require "rails_helper"

RSpec.describe("pages/primary-senior-leaders") do
  # TODO: can we read values from /app/config/locales/views/pages/primary-senior-leaders/en.yml ?
  let(:hero_title) { "Support for Primary Senior Leaders" }
  let(:quality_framework_tick_list_title) { "How we can help you and your school" }
  let(:stem_partner_title) { "STEM Ambassadors" }
  let(:code_club_partner_title) { "Code Club" }
  let(:barefoot_title) { "Barefoot" }

  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css("h1", text: hero_title)
  end

  it "has the TickListCollectionComponent" do
    expect(rendered).to have_css(".tick-list-collection-component__title", text: quality_framework_tick_list_title)
  end

  it "has the BorderedCardsComponent" do
    expect(rendered).to have_css(".teacher-help-cards")
  end

  it "has the partners listed" do
    expect(rendered).to have_css(".non-bordered-card__title", text: stem_partner_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: code_club_partner_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: barefoot_title)
  end
end
