require "rails_helper"

RSpec.describe LogoCardsComponent, type: :component do
  let(:test_data) do
    {
      class_name: "partner-resources",
      cards_per_row: 3,
      cards: [
        {
          image_url: "media/images/logos/stem-logo-with-bg.svg",
          title_link: {
            title: "Impact and evaluation",
            title_url: "https://www.stem.org.uk/impact-and-evaluation"
          }
        },
        {
          image_url: "media/images/logos/rpf-logo-with-bg.svg",
          title_link: {
            title: "Computing education research seminars",
            title_url: "https://www.raspberrypi.org/computing-education-research-online-seminars/"
          }
        },
        {
          image_url: "media/images/logos/bcs-logo-with-bg.svg",
          title_link: {
            title: "Academic publications",
            title_url: "https://www.bcs.org/more/learned-publishing/"
          }
        }
      ]
    }
  end

  before do
    render_inline(described_class.new(**test_data))
  end

  it "adds the wrapper class" do
    expect(page).to have_css(".partner-resources")
  end

  it "sets the expected properties" do
    expect(page).to have_xpath('//div[contains(@class, "logo-cards-component")][contains(@style, "--cards-per-row: 3;")]')
  end

  it "renders the expected number of cards" do
    expect(page).to have_css(".logo-card", count: 3)
  end

  it "renders an image" do
    expect(page).to have_css(".logo-card__image-wrapper")
  end

  it "has the expected link" do
    expect(page).to have_link("Impact and evaluation", href: "https://www.stem.org.uk/impact-and-evaluation")
  end
end
