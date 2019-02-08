require 'rails_helper'

RSpec.describe('pages/accelerator', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'The Computer Science Accelerator Programme')
  end

  it 'has a bursary link' do
    render
    expect(rendered).to have_link('Read about our bursaries', href: '/bursary')
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has no link' do
      expect(rendered).to have_text('Log in or create an account to see our face to face courses', count: 0)
    end

  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has a login link' do
      expect(rendered).to have_link('Log in or create an account to see our face to face courses', href: '/login')
    end
  end

end
