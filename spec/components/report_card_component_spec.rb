require "rails_helper"

RSpec.describe ReportCardComponent, type: :component do
  let(:test_data) do
    {
      class_name: "impact-and-evaluation-report-card",
      title: "Impact and evaluation",
      text: "View our latest impact reports.",
      bullets: %w[1 2 3 4],
      button: {
        button_title: "Impact and evaluation",
        button_url: "/impact-and-evaluation"
      },
      date: nil,
      stats_date: nil
    }
  end

  context "with no date" do
    before do
      render_inline(described_class.new(**test_data))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".impact-and-evaluation-report-card")
    end

    it "sets show-border data attribute" do
      expect(page).to have_css(".impact-and-evaluation-report-card[data-show-border='false']")
    end

    it "renders a title" do
      expect(page).to have_css(".report-card-component__title", text: "Impact and evaluation")
    end

    it "does not render any dates" do
      expect(page).not_to have_css(".report-card-component__date")
    end

    it "renders the body text" do
      expect(page).to have_css(".report-card-component__text", text: "View our latest impact reports.")
    end

    it "renders a button" do
      expect(page).to have_link("Impact and evaluation", href: "/impact-and-evaluation")
    end

    it "renders a list with the expected number of items" do
      expect(page).to have_css(".report-card-component__list li", count: 4)
    end
  end

  context "with a date" do
    before do
      test_data[:date] = "May 2021"
      render_inline(described_class.new(**test_data))
    end

    it "renders a date" do
      expect(page).to have_css(".report-card-component__date", text: "May 2021")
    end
  end

  context "with a stats date" do
    before do
      test_data[:stats_date] = "These stats are not accurate"
      render_inline(described_class.new(**test_data))
    end

    it "renders a stats date" do
      expect(page).to have_css(".report-card-component__date",
        text: "These stats are not accurate")
    end
  end
end
