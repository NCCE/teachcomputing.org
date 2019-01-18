require 'rails_helper'

RSpec.describe('pages/home/_mailing', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-stay-in-touch__heading', text: 'Stay up to date')
  end

  it 'has a correct number of labels' do
    expect(rendered).to have_css('.ncce-stay-in-touch__label', count: 2)
  end

  it 'has a correct number of inputs' do
    expect(rendered).to have_css('.ncce-stay-in-touch__input', count: 2)
  end

end
