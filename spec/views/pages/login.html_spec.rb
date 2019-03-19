require 'rails_helper'

RSpec.describe('pages/login', type: :view) do
  before do
    render template: 'pages/login', locals: { auth_uri: '/test/123' }
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-login__title', text: 'Create an account')
  end

  it 'button to create an account' do
    expect(rendered).to have_css('.ncce-signup__button', text: 'Create an account')
  end

  it 'links to create a STEM Learning account' do
    expect(rendered).to have_link('Create an account', href: signup_stem_path)
  end

  it 'button to log in' do
    expect(rendered).to have_css('.ncce-login__button', text: 'Log in')
  end

  it 'links to log in to a STEM Learning account' do
    expect(rendered).to have_link('Log in', href: '/test/123')
  end

  it 'links to about' do
    expect(rendered).to have_link('Read more about the consortium', href: '/about')
  end
end
