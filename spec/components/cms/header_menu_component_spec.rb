# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::HeaderMenuComponent, type: :component do
  before do
    render_inline(described_class.new(menu_items: [
      {
        label: "Drop down 1",
        menu_items: [
          {label: "Menu 1 Item 1", url: "/primary-certificate"},
          {label: "Menu 1 Item 2", url: "/primary-enrichment"}
        ]
      },
      {
        label: "Drop down 2",
        menu_items: [
          {label: "Menu 2 Item 1", url: "/secondary-certificate"},
          {label: "Menu 2 Item 2", url: "/secondary-enrichment"}
        ]
      }
    ]))
  end

  it "should render the drop downs" do
    expect(page).to have_css(".ncce-header__certification-item.dropdown__expander", count: 2)
  end

  it "should render all links" do
    expect(page).to have_css(".dropdown__expander-content-item", count: 4)
  end
end
