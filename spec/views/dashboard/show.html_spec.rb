require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  before do
    [programme, @programmes = Programme.all, activity]
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    @achievements = user.achievements
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Your dashboard')
  end

  it 'has progress section' do
    expect(rendered).to have_css('h2', text: 'Your record of achievement')
  end

  it 'has a link to certification' do
    expect(rendered).to have_link('certification', href: '/certification')
  end

  it 'has an aside' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has a link to download the diagnostic tool' do
    expect(rendered).to have_css('a', text: 'diagnostic tool')
  end
  context 'when certification flag is disabled' do
    before do
      @certification_enabled = false
      render
    end

    it 'doesn\'t show the certificate progress section' do
      expect(rendered).to have_css('h1', text: 'on the National Centre for Computing Education certificate in', count: 0)
    end

    it 'doesn\'t show the certificate progress section' do
      expect(rendered).to have_css('.certification__title', text: 'Your certificate', count: 0)
    end
  end

  context 'when the user hasn\'t enrolled onto the CS Accelerator programme' do
    before do
      @certification_enabled = true
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('h1', text: 'on the National Centre for Computing Education certificate in')
    end

    it 'shows the certificate name' do
      expect(rendered).to have_css('h2', text: 'GCSE computer science subject knowledge')
    end

    it 'shows the enrollment button' do
      expect(rendered).to have_link('Find out more & enroll', href: cs_accelerator_path)
    end
  end

  context 'when the user has enrolled onto the CS Accelerator programme' do
    before do
      @certification_enabled = true
      user_programme_enrolment
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.certification__title', text: 'Your certificate')
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link('GCSE computer science subject knowledge', href: programme_path(slug: programme.slug))
    end

    it 'shows the progress bar' do
      expect(rendered).to have_css('.certification-progress__fudge-bar', count: 1)
    end
  end
end
