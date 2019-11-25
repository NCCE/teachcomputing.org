require 'rails_helper'

RSpec.describe('pages/hubs', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Network of Computing Hubs')
  end

  it 'has the hubs areas' do
    render
    expect(rendered).to have_css('.hubs__area', count: 11)
  end

  it 'has the hubs locations' do
    render
    expect(rendered).to have_css('.hubs__location', count: 34)
  end
end
