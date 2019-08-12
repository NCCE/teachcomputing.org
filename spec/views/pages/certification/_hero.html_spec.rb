require 'rails_helper'

RSpec.describe('pages/certification/_hero', type: :view) do
  let(:programme) { create(:programme) }
  before do
    @programme = programme
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1.govuk-heading-m', text: programme.title)
  end

  it 'has one notepad image' do
    expect(rendered).to have_css('.certification-hero__image', count: 1)
  end

end
