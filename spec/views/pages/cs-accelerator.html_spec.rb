require 'rails_helper'

RSpec.describe('pages/cs-accelerator', type: :view) do
  let(:user) { create(:user) }

  it 'has a bursaries link' do
    render
    expect(rendered).to have_link('bursaries', href: '/bursaries')
  end

  it 'has a FAQ link' do
    render
    expect(rendered).to have_link('FAQ', href: '/')
  end

  it 'has diagram image' do
    render
    expect(rendered).to have_css('.cs-accelerator__image', count: 1)
  end

  it 'has aside section' do
    render
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has Enroll title' do
      expect(rendered).to have_css('.ncce-aside__title', text: "Enroll")
    end

    it 'has Enroll button' do
      expect(rendered).to have_css('.ncce-aside__button', text: "Entroll on this certificate")
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has How to enroll title' do
      expect(rendered).to have_css('.ncce-aside__title', text: "How to enroll")
    end

    it 'has Account button' do
      expect(rendered).to have_css('.ncce-aside__button', text: "Create an account")
    end

    it 'has a Log in link' do
      render
      expect(rendered).to have_link('log in', href: '/login')
    end
  end



end
