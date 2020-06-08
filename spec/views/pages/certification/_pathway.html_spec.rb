require 'rails_helper'

RSpec.describe('pages/certification/_pathway', type: :view) do
	let(:programme) { create(:cs_accelerator) }

  before do
		@programme = programme
    render
  end

  it 'has the title' do
    expect(rendered).to have_css('.govuk-heading-s', text: 'Learning pathways for teachers')
  end

  it 'has all items' do
    expect(rendered).to have_css('.pathway__item', count: 5)
  end

  it 'has a courses link' do
    expect(rendered).to have_css('.button', text: 'Browse our courses')
  end

end
