require 'rails_helper'

RSpec.describe('programmes/_exam_activity', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
  end

  context 'when user is not ready for exam' do
    before do
      render
    end

    it 'shows the exam activity information' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', text: 'Pass the final test')
    end

    it 'shows the exam activity points' do
      expect(rendered).to have_css('ul>li', count: 6)
    end

    it 'shows the certificate graphic' do
      expect(rendered).to have_css('.certification-progress__image--exam', count: 1)
    end

    it 'shows the mobile certificate graphic' do
      expect(rendered).to have_css('.certification-progress__image--mobile-exam', count: 1)
    end

    it 'tells the user to get more credits' do
      expect(rendered).to have_css('span', text: 'The test will be available when you have completed the necessary courses')
    end
  end

  context 'when user has enough credits to take the test' do
    before do
      @can_take_test_at = 0
      @enough_credits_for_test = true
      render
    end

    it 'tells the user they can take the test' do
      expect(rendered).to have_css('span', text: 'You are allowed two initial attempts at the test before a 48 hour cool off period between each subsequent attempt. Good luck!')
    end

    it 'has a link to the test' do
      expect(rendered).to have_link('Take the final test')
    end
  end

  context 'when user is taking the test' do
    before do
      @currently_taking_test = true
      @enough_credits_for_test = true
      render
    end

    it 'tells the user they can take the test' do
      expect(rendered).to have_css('span', text: 'You are currently taking the test.  If you have recently failed, please come back in 2 hours.')
    end

    it 'has no link to the test' do
      expect(rendered).to have_link('Take the final test', count: 0)
    end
  end

  context 'when user has failed the test 3 times' do
    before do
      @enough_credits_for_test = true
      @can_take_test_at = 48.hours.to_i
      @num_attempts = 3
      render
    end

    it 'tells the user they\'re on the 4th attempt' do
      expect(rendered).to have_css('span', text: /Your fourth attempt at the test can be done/)
    end

    it 'tells the user to wait 48.hours' do
      expect(rendered).to have_css('strong', text: /after #{(Time.zone.now + 48.hours.to_i).strftime('%l%P on %A')}/)
    end

    it 'has no link to the test' do
      expect(rendered).to have_link('Take the final test', count: 0)
    end
  end

  context 'when user has passed the test' do
    before do
      @passed_assessment = true
      render
    end

    it 'marks as complete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'hides the status section' do
      expect(rendered).to have_css('.ncce-activity-list__item', count: 1)
    end

    it 'shows the correct text' do
      expect(rendered).to have_css('.ncce-activity-list__item', text: 'Passed the final test')
    end

    it 'has no link to the test' do
      expect(rendered).to have_link('Take the final test', count: 0)
    end

  end
end
