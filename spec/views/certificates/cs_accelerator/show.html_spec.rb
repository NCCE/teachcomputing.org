require "rails_helper"

RSpec.describe("certificates/cs_accelerator/show", type: :view) do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }

  before do
    @csa_dash = CSADash.new(user: user)
    @current_user = user
    @programme = programme
    render
  end

  it "has the hero" do
    expect(rendered).to have_css(".hero__heading", text: programme.title)
  end

  it "has a heading" do
    expect(rendered).to have_css(".govuk-heading-m")
  end

  it "has an activity heading" do
    expect(rendered).to have_css(".govuk-heading-s")
  end
end
