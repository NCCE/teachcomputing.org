require "rails_helper"

RSpec.describe("certificates/primary_certificate/complete", type: :view) do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:programme) { create(:programme, slug: "primary-certificate") }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }

  before do
    stub_issued_badges(user.id)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    assign(:complete_achievements, user.achievements.belonging_to_programme(programme).sort_complete_first)
    enrolment.transition_to(:complete)
    render
  end

  it "has the programme title" do
    expect(rendered).to have_css(".hero__heading", text: programme.title)
  end

  it "has the download button" do
    expect(rendered).to have_link("Download your certificate", href: "/certificate/primary-certificate/view-certificate")
  end

  it "has the journey section" do
    expect(rendered).to have_css(".ncce-programmes-activity__title", text: "Your learning journey")
  end

  it "has the roa" do
    expect(rendered).to have_css(".primary-certificate__complete", count: 1)
  end

  it "has the Twitter share button" do
    expect(rendered).to have_link("Share on Twitter", href: "https://twitter.com/intent/tweet?text=#{CGI.escape "I have completed the Teach primary computing certificate from @WeAreComputing. Sign up: #{primary_url}"}")
  end

  it "has the Facebook share button" do
    expect(rendered).to have_link("Share on Facebook", href: "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape primary_url}")
  end

  it "has the LinkedIn share button" do
    expect(rendered).to have_link("Share on LinkedIn", href: "https://www.linkedin.com/shareArticle?mini=true&url=#{CGI.escape primary_url}")
  end
end
