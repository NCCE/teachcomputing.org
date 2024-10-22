require "rails_helper"

RSpec.describe MixedCardsComponent, type: :component do
  let(:file_card) do
    {
      name: "Example file 1",
      file: "https://www.example.com/",
      type: "JPG",
      size: "1 Megabyte",
      created: "14 Oct 2021"
    }
  end

  let(:link_card) do
    {
      title: "Testing",
      link: "https://www.example.com",
      file_type: "Google Doc"
    }
  end

  describe "with only external_link_card defined" do
    before do
      render_inline(described_class.new(cards: [
        {type: :external_link, details: link_card}
      ]))
    end

    it "renders with the expected link" do
      expect(page).to have_link("Testing", href: "https://www.example.com")
    end

    it "renders the file type text" do
      expect(page).to have_text("Google Doc")
    end
  end

  describe "should render all with mixed types" do
    before do
      render_inline(described_class.new(cards: [
        {type: :external_link, details: link_card},
        {type: :file, details: file_card}
      ]))
    end

    it "renders with the expected external link" do
      expect(page).to have_link("Testing", href: "https://www.example.com")
    end

    it "renders with the expected file card" do
      expect(page).to have_link("Example file 1", href: "https://www.example.com/")
    end
  end
end
