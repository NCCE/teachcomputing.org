require "rails_helper"

RSpec.describe BenchmarkBannerComponent, type: :component do
  context "with single icon" do
    before do
      render_inline(
        described_class.new(
          icons: [
            "media/images/pages/careers-support/benchmark_1.svg"
          ]
        )
      )
    end

    it "renders the title text" do
      expect(page).to have_text("Benchmark")
    end
  end

  context "with multiple icon" do
    before do
      render_inline(
        described_class.new(
          icons: [
            "media/images/pages/careers-support/benchmark_1.svg",
            "media/images/pages/careers-support/benchmark_2.svg"
          ]
        )
      )
    end

    it "renders the title text" do
      expect(page).to have_text("Benchmarks")
    end
  end

  context "with align right" do
    before do
      render_inline(
        described_class.new(
          icons: [
            "media/images/pages/careers-support/benchmark_1.svg"
          ],
          align_right: true
        )
      )
    end

    it "to append the class" do
      expect(page).to have_css("div.benchmark-banner__icons--align-right")
    end
  end
end
