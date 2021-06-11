require 'rails_helper'

RSpec.describe('pages/supporting-partners', type: :view) do
    before do
      render
    end

    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-xl', text: 'Supporting partners')
    end

    it 'has a sub title' do
      expect(rendered).to have_css('.govuk-heading-l', text: 'Thank you to our existing partners')
    end

    it 'has supporting partner cards showing' do
      expect(rendered).to have_css('.shadow_card', count: 6)
    end

    it 'has external links for each of the supporting_partner cards' do
      current_supporting_partners_logo_links = [
        'https://www.arm.com/',
        'https://www.bt.com/skillsfortomorrow',
        'https://edu.google.com/teaching-resources/?modal_active=none&topic=coding-and-computer-science',
        'https://www.nationwide-jobs.co.uk/',
        'https://www.stem.org.uk/rolls-royce-schools-prize-science-technology',
      ]

    current_supporting_partners_logo_links.each do |link|
      expect(rendered).to have_link(href: link)
    end
  end
end
