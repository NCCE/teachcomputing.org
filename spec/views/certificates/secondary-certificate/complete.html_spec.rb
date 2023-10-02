require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/complete', type: :view) do
  let(:user) { create(:user, email: 'web@teachcomputing.org') }
  let(:secondary_certificate) { create(:secondary_certificate) }

  before do
    stub_issued_badges(user.id)
    @programme = secondary_certificate
    assign(:complete_achievements, user.achievements.belongs_to_programme(secondary_certificate).sort_complete_first)
    assign(:current_user, user)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('Download your certificate', href: '/certificate/secondary-certificate/view-certificate')
  end

  it 'has the Browse all courses button' do
    expect(rendered).to have_link('Browse all courses', href: '/courses')
  end

  it 'has Find out more about CAS button' do
    expect(rendered).to have_link('Find out more', href: 'https://community.computingatschool.org.uk/events')
  end

  it 'has the journey section' do
    expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your learning journey')
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Share your success')
  end

  it 'has the Twitter share button' do
    expect(rendered).to have_link('Share on Twitter', href: "https://twitter.com/intent/tweet?text=#{CGI.escape "I have completed the Teach secondary computing programme from @WeAreComputing. Find out more #{secondary_url}"}")
  end

  it 'has the Facebook share button' do
    expect(rendered).to have_link('Share on Facebook', href: "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape secondary_url}")
  end

  it 'has the LinkedIn share button' do
    expect(rendered).to have_link('Share on LinkedIn', href: "https://www.linkedin.com/shareArticle?mini=true&url=#{CGI.escape secondary_url}")
  end
end
