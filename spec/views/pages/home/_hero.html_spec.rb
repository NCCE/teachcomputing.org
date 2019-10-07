require 'rails_helper'

RSpec.describe('pages/home/_hero', type: :view) do
  let(:user) { create(:user) }
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-hero', text: 'Helping you teach computing')
  end

  it 'button to find out more about NCCE' do
    expect(rendered).to have_link('Get started!', href: /register/)
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'button to find out more about NCCE' do
      expect(rendered).to have_link('Get started!', href: dashboard_path)
    end
  end
end
