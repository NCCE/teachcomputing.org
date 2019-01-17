require 'rails_helper'

RSpec.describe('pages/login', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-login__title', text: 'Create an account')
  end

  it 'button to sign up' do
    expect(rendered).to have_css('.ncce-login__button', text: 'Sign up')
  end

  it 'links to the Stem account' do
    expect(rendered).to have_link('Sign up', href: signup_stem_path)
  end
end
