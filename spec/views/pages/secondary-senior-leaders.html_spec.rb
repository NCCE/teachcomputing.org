require "rails_helper"

RSpec.describe("pages/secondary-senior-leaders") do
  # TODO: can we read values from /app/config/locales/views/pages/secondary-senior-leaders/en.yml ?
  let(:hero_title) { "Support for Secondary Senior Leaders" }
  let(:quality_framework_tick_list_title) { "How we can help you and your school or college" }
  let(:student_help_title) { "How we can help you and your students" }
  let(:stem_partner_title) { "STEM Ambassadors" }
  let(:code_club_partner_title) { "Code Club" }
  let(:bebras_partner_title) { "Bebras UK" }

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

  it "has the LogoButtonImageCardComponent" do
    expect(rendered).to have_css(".logo-button-image-card-component__title", text: student_help_title)
  end

  it "has the partners listed" do
    expect(rendered).to have_css(".non-bordered-card__title", text: stem_partner_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: code_club_partner_title)
    expect(rendered).to have_css(".non-bordered-card__title", text: bebras_partner_title)
  end
end
