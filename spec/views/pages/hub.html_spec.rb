require 'rails_helper'

RSpec.describe('pages/hub', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'Network of Computing Hubs')
  end

  it 'has a STEAM link' do
    render
    expect(rendered).to have_link('Find out how your school can apply', href: 'https://www.stem.org.uk/opportunities-tender')
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has no aside panel' do
      expect(rendered).to have_css('.ncce-aside', count: 0)
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has aside panel' do
      expect(rendered).to have_css('.ncce-aside', count: 1)
    end
  end

end
