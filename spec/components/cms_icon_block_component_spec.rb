# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsIconBlockComponent, type: :component do
  let(:icon_block_one_icon) { Cms::Mocks::IconBlocks.as_model }

  let(:icon_block_two_icons) { Cms::Mocks::IconBlocks.as_model(icon_count: 2) }

  context "with one icon" do
    before do
      render_inline(described_class.new(icons: icon_block_one_icon.icons))
    end

    it "renders the icon text" do
      expect(page).to have_text(icon_block_one_icon.icons.first.text)
    end

    it "renders the intro text" do
      expect(page).to have_css("img")
    end
  end

  context "with two icons" do
    before do
      render_inline(described_class.new(icons: icon_block_two_icons.icons))
    end

    it "renders two icons" do
      expect(page).to have_css(".icon-wrapper__block", count: 2)
    end
  end

  context "with no icons" do
    before do
      render_inline(described_class.new(icons: []))
    end

    it "does not render if no icons present" do
      expect(page).to_not have_css(".icon-wrapper__block")
    end
  end
end
