require 'rails_helper'

RSpec.describe('pages/secondary-senior-leaders') do
  let(:title) { 'Support for Secondary Senior Leaders' }

  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_title(title)
    expect(rendered).to have_css('h1', text: title)
  end
end
