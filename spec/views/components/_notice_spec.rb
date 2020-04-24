require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'ANNOUNCEMENT')
  end

  it 'read our full statement' do
    expect(rendered).to have_link('resources and partner websites', href: 'https://teachcomputing.org/home-teaching/')
  end
end
