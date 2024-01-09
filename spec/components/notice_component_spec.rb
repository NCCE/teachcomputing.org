require "rails_helper"

RSpec.describe NoticeComponent, type: :component do
  let(:data) do
    {
      class_name: "lime-green-bg",
      icon: {
        url: "media/images/icons/raspberry-pi.svg",
        title: "Image title"
      },
      title: "Test title",
      text: "Test text",
      link: {
        url: "https://www.example.com",
        text: "Link text",
        tracking_label: "Something"
      },
      tracking_category: "Notice"
    }
  end

  before do
    render_inline(described_class.new(**data))
  end

  it "adds the wrapper class" do
    expect(page).to have_css(".lime-green-bg")
  end

  it "renders an icon" do
    expect(page).to have_css("img[src*='raspberry-pi']")
  end

  it "renders the title" do
    expect(page).to have_css(".notice-component__title", text: "Test title")
  end

  it "renders the body text" do
    expect(page).to have_css(".notice-component__text", text: "Test text")
  end

  it "renders a link" do
    expect(page).to have_link("Link text", href: "https://www.example.com")
  end
end
