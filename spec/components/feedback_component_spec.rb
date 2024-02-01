require "rails_helper"

RSpec.describe FeedbackComponent, type: :component do
  before do
    render_inline(described_class.new(heading: "Test heading", area:
                                      :test_area))
  end

  it "renders the provided heading" do
    expect(page).to have_text("Test heading")
  end

  it "adds area to form" do
    expect(page)
      .to have_field("feedback_comment_area", type: :hidden, with: "test_area")
  end
end
