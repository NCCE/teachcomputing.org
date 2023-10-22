require 'rails_helper'

RSpec.describe('certificates/a_level/complete', type: :view) do
  let(:user) { create(:user, email: 'web@teachcomputing.org') }
  let(:programme) { create(:a_level) }
  let(:enrolment) { create(:user_programme_enrolment, programme:, user:) }

  before do
    stub_issued_badges(user.id)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    assign(:complete_achievements, user.achievements.belonging_to_programme(programme).sort_complete_first)
    enrolment.transition_to(:complete)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('Download your certificate', href: '/certificate/a-level-certificate/view-certificate')
  end

  it 'has the next steps section' do
    expect(rendered).to have_css('.govuk-body-l', text: 'Next steps for your development')
  end

  it 'has the X share button' do
    expect(rendered).to have_link('Share on X', href: "https://twitter.com/intent/tweet?text=#{CGI.escape "I have completed the A-Level programme from @WeAreComputing. Find out more #{about_a_level_url}"}")
  end

  it 'has the Facebook share button' do
    expect(rendered).to have_link('Share on Facebook', href: "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape about_a_level_url}")
  end

  it 'has the LinkedIn share button' do
    expect(rendered).to have_link('Share on LinkedIn', href: "https://www.linkedin.com/shareArticle?mini=true&url=#{CGI.escape about_a_level_url}")
  end
end
