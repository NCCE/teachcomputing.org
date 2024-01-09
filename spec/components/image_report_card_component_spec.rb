require "rails_helper"

RSpec.describe ImageReportCardComponent, type: :component do
  let(:test_data) do
    {
      class_name: "impact-and-evaluation-report-card",
      title: "Impact and evaluation",
      text: "View our latest impact reports.",
      button: {
        button_title: "Impact and evaluation",
        button_url: "/impact-and-evaluation"
      },
      image: {
        path: "media/images/pages/impact/impact_report.png",
        alt: "Image"
      },
      date: nil
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
      expect(page).to have_css(".image-report-card-component__title", text: "Impact and evaluation")
    end

    it "does not render any dates" do
      expect(page).not_to have_css(".image-report-card-component__date")
    end

    it "renders the body text" do
      expect(page).to have_css(".image-report-card-component__text", text: "View our latest impact reports.")
    end

    it "renders a button" do
      expect(page).to have_link("Impact and evaluation", href: "/impact-and-evaluation")
    end

    it "renders an image" do
      expect(page).to have_css("img[src*='impact_report']")
    end
  end

  context "with a date" do
    before do
      test_data[:date] = "May 2021"
      render_inline(described_class.new(**test_data))
    end

    it "renders a date" do
      expect(page).to have_css(".image-report-card-component__date", text: "May 2021")
    end
  end
end
