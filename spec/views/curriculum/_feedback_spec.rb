require "rails_helper"

RSpec.describe("curriculum/_feedback", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".padded-box__title", text: "Help us make these resources better")
  end

  it "links to feedback form" do
    expect(rendered).to have_link("Provide your feedback", href: "https://survey.alchemer.eu/s3/90535031/National-Centre-for-Computing-Education-Teach-Computing-Curriculum-Feedback")
  end
end
