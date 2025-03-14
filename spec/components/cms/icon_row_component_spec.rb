# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::IconRowComponent, type: :component do
  before do
    render_inline(described_class.new(icons: Array.new(2) { Cms::Mocks::Icon.as_model }, background_color: nil))
  end

  it "should render images" do
    expect(page).to have_css(".cms-image", count: 2)
  end

  it "should render multiple icons" do
    expect(page).to have_css(".cms-icon-row-component__icon", count: 2)
  end
end
