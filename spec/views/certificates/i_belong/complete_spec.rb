require "rails_helper"

RSpec.describe("certificates/i_belong/complete", type: :view) do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:programme) { create(:i_belong) }
  let(:enrolment) { create(:user_programme_enrolment, programme:, user:) }

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

  it "doesn't have the download button" do
    expect(rendered).to have_no_link("Download your certificate", href: "/certificate/i-belong/view-certificate")
  end

  it "should have a modal asking for school name" do
    expect(rendered).to have_text("To obtain your school’s certificate, please enter the name of your school. The name provided will be printed onto the certificate.")
  end

  it "has the next steps section" do
    expect(rendered).to have_css(".govuk-body-l", text: "Next steps for you")
  end

  it "has the Twitter share button" do
    expect(rendered).to have_link("Share on Twitter", href: "https://twitter.com/intent/tweet?text=#{CGI.escape "I have completed the I Belong programme from @WeAreComputing. Find out more #{about_i_belong_url}"}")
  end

  it "has the Facebook share button" do
    expect(rendered).to have_link("Share on Facebook", href: "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape about_i_belong_url}")
  end

  it "has the LinkedIn share button" do
    expect(rendered).to have_link("Share on LinkedIn", href: "https://www.linkedin.com/shareArticle?mini=true&url=#{CGI.escape about_i_belong_url}")
  end

  context "when the user has their school set" do
    let(:user) { create(:user, email: "web@teachcomputing.org", school_name: "asdfasdf") }
    let(:enrolment) { create(:user_programme_enrolment, programme:, user:) }

    it "has the download button" do
      expect(rendered).to have_link("Download your certificate", href: "/certificate/i-belong/view-certificate")
    end
  end
end
