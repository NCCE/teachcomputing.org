require "rails_helper"
require "faker"

RSpec.describe YouTubeEmbedComponent, type: :component do
  let(:invalid_youtube_url) { Faker::Internet.url }
  let(:invalid_url) { Faker::Lorem.sentence }

  context "it has a valid url" do
    before do
      render_inline(described_class.new(video_url: "https://www.youtube.com/watch?v=l9ZTDi72yGU&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J"))
    end
    it "draws an iframe" do
      expect(page).to have_css("iframe")
    end

    it "iframe has the correct src" do
      expect(page).to have_css("iframe[src='https://www.youtube.com/embed/l9ZTDi72yGU']")
    end
  end
  context "it has an invalid youtube url" do
    before do
      render_inline(described_class.new(video_url: invalid_youtube_url))
    end
    it "does not draw an iframe" do
      expect(page).not_to have_css("iframe")
    end
  end

  context "it has an invalid url" do
    before do
      render_inline(described_class.new(video_url: invalid_url))
    end
    it "does not draw an iframe" do
      expect(page).not_to have_css("iframe")
    end
  end
end
