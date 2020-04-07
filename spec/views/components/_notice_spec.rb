require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'COVID19')
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-s', text: 'How the Teach Computing service is responding to Coronavirus (COVID-19)')
  end

  it 'has a list' do
    expect(rendered).to have_css('.govuk-list--bullet', count: 1)
  end

  it 'read our full statement' do
    expect(rendered).to have_link('Read our full statement on COVID19', href: 'https://blog.teachcomputing.org/coronavirus-update/')
  end



end
