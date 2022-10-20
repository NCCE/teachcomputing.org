require "rails_helper"

RSpec.describe BorderedListCardsComponent, type: :component do
  let(:test_data) { GetInvolved.other_ways_to_get_involved_cards }

  context 'other ways to get involved cards' do
    before do
      test_data[:cards][0][:image_url] = 'media/images/logos/isaac-logo-with-bg.svg'
      render_inline(described_class.new(**test_data))
    end

    it 'has the expected links' do
      expect(rendered_component).to have_link('Volunteer at a Code Club', href: 'https://codeclub.org/en/volunteer')
      expect(rendered_component).to have_link('Become an Ambassador', href: 'https://www.stem.org.uk/stem-ambassadors/join-stem-ambassador-programme')
      expect(rendered_component).to have_link('Help at a Discovery event', href: 'https://isaaccomputerscience.org/pages/getintouch_events')
      expect(rendered_component).to have_link('Join Computing at School', href: 'https://www.computingatschool.org.uk/')
      expect(rendered_component).to have_link('Advocate for us', href: 'https://teachcomputing.org/governors-and-trustees/')
    end

    it 'sets the expected properties' do
      pending('Add test that checks custom properties are set correctly')
      expect(rendered_component).to have_css('--cards-per-row: 3;')
    end

    it 'adds the wrapper class' do
      expect(rendered_component).to have_css('.support-cards')
    end

    it 'renders the expected number of cards' do
      expect(rendered_component).to have_css('.bordered-card', count: 5)
    end

    it 'renders an image' do
      expect(rendered_component).to have_css('.bordered-card__image-wrapper')
    end
  end
end
