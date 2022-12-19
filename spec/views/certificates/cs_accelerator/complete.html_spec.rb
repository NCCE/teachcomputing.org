require 'rails_helper'

RSpec.describe('certificates/cs_accelerator/complete', type: :view) do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let!(:diagostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: diagostic_activity.id) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }

  before do
    stub_issued_badges(user.id)
    programme.activities << diagostic_activity
    @online_achievements = []
    @face_to_face_achievements = []
    achievement.transition_to(:complete)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    enrolment.transition_to(:complete)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('Download your certificate (PDF)', href: '/certificate/cs-accelerator/view-certificate')
  end

  it 'has a link to the secondary certificate page' do
    expect(rendered).to have_link('Secondary computing certificate', href: '/certificate/secondary-certificate')
  end

  it 'has a button to enrol on the secondary certificate' do
    expect(rendered).to have_link('Enrol', href: "/certificate/secondary-certificate/enrol?user_programme_enrolment%5Bprogramme_id%5D=#{secondary_certificate.id}&user_programme_enrolment%5Buser_id%5D=#{user.id}")
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.share-aside .aside-component__heading', text: 'Share your success')
  end

  it 'has the Twitter share button' do
    expect(rendered).to have_link('Share on Twitter', href: 'https://twitter.com/intent/tweet?text=I%20have%20completed%20the%20Computer%20Science%20Accelerator%20from%20%40WeAreComputing.%20Sign%20up:%20https://teachcomputing.org%2Fcs-accelerator')
  end

  it 'has the Facebook share button' do
    expect(rendered).to have_link('Share on Facebook', href: 'https://www.facebook.com/sharer/sharer.php?u=https://teachcomputing.org%2Fcs-accelerator')
  end

  it 'has the LinkedIn share button' do
    expect(rendered).to have_link('Share on LinkedIn', href: 'https://www.linkedin.com/shareArticle?mini=true&url=https://teachcomputing.org/cs-accelerator')
  end
end
