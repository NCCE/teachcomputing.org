require 'rails_helper'

RSpec.describe('pages/secondary-teachers', type: :view) do
  let(:programme) { create(:cs_accelerator ) }

  before do
    programme
  end

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-l', text: 'The essential toolkit for secondary computing teachers')
  end

  it 'has embedded vide' do
    render
    expect(rendered).to have_css('video', count: 1)
  end
end
