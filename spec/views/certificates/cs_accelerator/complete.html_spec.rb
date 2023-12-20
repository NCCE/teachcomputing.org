require 'rails_helper'

RSpec.describe('certificates/cs_accelerator/complete') do
  let(:user) { create(:user, email: 'web@teachcomputing.org') }
  let!(:online_activity) { create(:activity, :future_learn, stem_activity_code: "CP228") }
  let(:programme) { create(:programme, slug: 'subject-knowledge') }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let(:pathway) { create(:pathway, pdf_link: 'http://example.com') }

  before do
    stub_issued_badges(user.id)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    create(:pathway_activity, pathway_id: pathway.id, activity_id: online_activity.id)
    create(:completed_enrolment, programme_id: programme.id, user_id: user.id)
    create(:completed_achievement, user_id: user.id, activity_id: online_activity.id)

    assign(:current_user, user)
    assign(:programme, programme)
    assign(:other_programme_pathways_for_user, [pathway])
  end

  context 'when the user is not on a pathway' do
    before do
      render
    end

    it 'has the programme title' do
      expect(rendered).to have_css('.hero__heading', text: programme.title)
    end

    it 'shows the certificate has been awarded' do
      expect(rendered).to have_css('.hero__wrapper', text: 'Certificate awarded')
      expect(rendered).to have_css('.status-block--completed', text: 'Certificate awarded')
    end

    it 'has the download button' do
      expect(rendered).to have_link('Download your certificate (PDF)', href: '/certificate/subject-knowledge/view-certificate')
    end

    it 'has a link to the secondary certificate page' do
      expect(rendered).to have_link('Secondary computing certificate', href: '/certificate/secondary-certificate')
    end

    it 'has a button to find out more about the secondary certificate' do
      expect(rendered).to have_link('Find out more')
    end

    it 'has two further activity cards' do
      expect(rendered).to have_css('.further-activity-cards')
      expect(rendered).to have_css('.bordered-card', count: 2)
    end

    it 'does not show the recommended pathways' do
      expect(rendered).not_to have_css('.recommended-courses-wrapper')
    end

    it 'does not show the additional pathways' do
      expect(rendered).not_to have_css('.supplementary-courses__header')
    end

    it 'has a code club link' do
      expect(rendered).to have_link('Code Club', href: 'https://codeclub.org/en/start-a-code-club')
    end

    it 'has a CAS link' do
      expect(rendered).to have_link('Find out more', href: 'https://community.computingatschool.org.uk/events')
    end

    it 'has a subsidy section' do
      expect(rendered).to have_link('this form', href: 'https://static.teachcomputing.org/BACS+form+-+NCCE.docx')
      expect(rendered).to have_link('finance@stem.org.uk', href: 'mailto:finance@stem.org.uk')
    end

    it 'has a support section' do
      expect(rendered).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
    end

    it 'has a useful documents section' do
      expect(rendered).to have_link('Download our Handbook', href: 'https://static.teachcomputing.org/CS_Accelerator_handbook.pdf')
      expect(rendered).to have_link('Download our GCSE Specification Map', href: 'https://static.teachcomputing.org/GCSE_specifications_to_CSA_course_map.pdf')
    end

    it 'has the Twitter section' do
      expect(rendered).to have_css('.share-aside .aside-component__heading', text: 'Share your success')
    end

    it 'has the Twitter share button' do
      expect(rendered).to have_link('Share on Twitter', href: 'https://twitter.com/intent/tweet?text=I%20have%20completed%20the%20Computer%20Science%20Accelerator%20from%20%40WeAreComputing.%20Sign%20up:%20https://teachcomputing.org%2Fsubject-knowledge')
    end

    it 'has the Facebook share button' do
      expect(rendered).to have_link('Share on Facebook', href: 'https://www.facebook.com/sharer/sharer.php?u=https://teachcomputing.org%2Fsubject-knowledge')
    end

    it 'has the LinkedIn share button' do
      expect(rendered).to have_link('Share on LinkedIn', href: 'https://www.linkedin.com/shareArticle?mini=true&url=https://teachcomputing.org/subject-knowledge')
    end

    context 'when it renders the pathway switcher' do
      it 'has the expected title' do
        expect(rendered).to have_css('.ncce-csa-dash__pathway-switcher', text: 'Get course recommendations with pathways')
      end

      it 'has the expected select text' do
        expect(rendered).to have_css('.ncce-csa-dash__pathway-switcher', text: 'Select your new pathway')
      end

      it 'has the expected button text' do
        expect(rendered).to have_button('Select pathway')
      end
    end

  end

  context 'when the user is on a pathway' do
    before do
      assign(:user_pathway, pathway)
      assign(:recommended_activities, [online_activity])
      stub_course_templates
      stub_duration_units
      render
    end

    it 'links to the pdf in the pathway title' do
      expect(rendered).to have_link('your pathway', href: 'http://example.com')
    end

    it 'does show the recommended pathways' do
      expect(rendered).to have_css('.recommended-courses-wrapper')
    end

    it 'does show the additional pathways' do
      expect(rendered).to have_css('.supplementary-courses__header')
    end

    it 'shows when a user has made progress on a course in both recommended and additional pathway activities' do
      expect(rendered).to have_css('.ncce-pathway-courses__status', text: 'Completed')
    end

    context 'when it renders the pathway switcher' do
      it 'has the expected title' do
        expect(rendered).to have_css('.ncce-csa-dash__pathway-switcher', text: 'Not sure this is the right pathway for you? See what our other pathways include')
      end

      it 'has the expected select text' do
        expect(rendered).to have_css('.ncce-csa-dash__pathway-switcher', text: 'Select your new pathway')
      end

      it 'has the expected button text' do
        expect(rendered).to have_button('Select pathway')
      end
    end
  end
end
