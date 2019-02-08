require 'rails_helper'

RSpec.describe('pages/home/_sign-up', type: :view) do
  let(:user) { create(:user) }

  it('renders the correct number of bullets') do
    render
    expect(rendered).to(have_css('.ncce-sign-up__list--item', count: 3))
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has a title' do
      expect(rendered).to have_css('.ncce-sign-up', text: 'Visit your dashboard')
    end

    it 'links to the Sign up section' do
      expect(rendered).to have_link('Visit your dashboard', href: '/dashboard')
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end
    it 'has a title' do
      expect(rendered).to have_css('.ncce-sign-up', text: 'Create an account')
    end

    it 'links to the Sign up section' do
      expect(rendered).to have_link('Create an account', href: '/login')
    end
  end

end
