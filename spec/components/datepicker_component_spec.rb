require "rails_helper"

RSpec.describe DatepickerComponent, type: :component do
  before do
    render_inline(described_class.new("test"))
  end

  it "should render the component" do
    expect(page).to have_css(".flatpickr")
  end

  it "should bind the controller in data" do
    expect(page).to have_css("div[data-controller='flatpickr']")
  end
end
