require 'rails_helper'

RSpec.describe('home/_jobs', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-jobs-container', text: 'Get involved')
  end

  it('renders the correct number of subtitles') do
    expect(rendered).to(have_css('.ncce-jobs__heading', count: 3))
  end

end
