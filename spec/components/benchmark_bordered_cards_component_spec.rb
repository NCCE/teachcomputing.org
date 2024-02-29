require "rails_helper"

RSpec.describe BenchmarkBorderedCardsComponent, type: :component do
  before do
    render_inline(
      described_class.new(
        cards: [
          {
            title: "Testing",
            text: "Pellentesque commodo eros a enim. Sed fringilla mauris sit amet nibh.",
            benchmark_icons: [
              "media/images/pages/careers-support/benchmark_1.svg"
            ]
          }
        ]
      )
    )
  end

  it "should have benchmark banner component" do
    expect(page).to have_css("div.benchmark-banner-wrapper")
  end

  it "should render title" do
    expect(page).to have_text("Testing")
  end

  it "should render text" do
    expect(page).to have_text("Pellentesque")
  end
end
