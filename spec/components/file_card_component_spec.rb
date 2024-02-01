require "rails_helper"

RSpec.describe FileCardComponent, type: :component do
  let(:file_card) do
    {
      name: "Example file 1",
      file: "https://www.example.com/",
      type: "JPG",
      size: "1 Megabyte",
      created: "14 Oct 2021"
    }
  end

  describe "with no title defined" do
    before do
      render_inline(described_class.new(file_card: file_card))
    end

    it "renders with the expected link" do
      expect(page).to have_link("Example file 1", href: "https://www.example.com/")
    end

    it "renders with the expected file type" do
      expect(page).to have_text("JPG")
    end

    it "renders with the expected file size" do
      expect(page).to have_text("1 Megabyte")
    end

    it "renders with the expected created date" do
      expect(page).to have_text("14 Oct 2021")
    end
  end

  describe "with a title defined" do
    it "renders with the expected link" do
      render_inline(described_class.new(file_card: file_card, title: "I have a more important title"))
      expect(page).to have_link("I have a more important title", href: "https://www.example.com/")
    end
  end
end
