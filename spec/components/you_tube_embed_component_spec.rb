require "rails_helper"

RSpec.describe YouTubeEmbedComponent, type: :component do
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
