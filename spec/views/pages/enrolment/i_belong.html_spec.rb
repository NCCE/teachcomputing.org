require "rails_helper"

RSpec.describe("pages/enrolment/i_belong", type: :view) do
  before do
    render(
      template: "pages/enrolment/i_belong",
      locals:
        {session_state: :unenrolled,
         cta_link_path: "/",
         cta_link_method: :post,
         posters_link_title: "Request posters",
         posters_link: "https://forms.office.com/e/x1FMMzjxhg",
         posters_link_method: :get,
         primary_handbook_download_url: "https://media.teachcomputing.org/i_belong_primary_handbook_cd22a59080.pdf",
         secondary_handbook_download_url: "https://media.teachcomputing.org/i_belong_secondary_handbook_2f4dfccf30.pdf",
         handbook_download_title: "Download your handbook"}
    )
  end

  it "has a title section" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "I Belong: encouraging girls into computer science")
  end

  it "has a description section" do
    expect(rendered).to have_content("Computer science is the fastest-growing STEM subject, and yet, despite its popularity, girls are consistently outnumbered by boys.")
  end

  it "has a video" do
    expect(rendered).to have_css(".video-with-text", count: 1)
  end

  it "shows 3 support cards" do
    expect(rendered).to have_css(".lp-support__card", count: 3)
  end

  it "has 7 resource cards" do
    expect(rendered).to have_css(".non-bordered-card", count: 7)
  end

  it "has a log in to enrol button" do
    expect(rendered).to have_link("Log in to enrol")
  end
end
