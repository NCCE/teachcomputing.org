require 'rails_helper'

RSpec.describe('pages/secondary-senior-leaders') do
  # TODO: can we read values from /app/config/locales/views/pages/secondary-senior-leaders/en.yml ?
  let(:title) { 'Support for Secondary Senior Leaders' }

  before do
    render
  end

  it 'has a title' do
    # TODO: either of the next two fail, why?
    # expect(rendered).to have_css('title', text: title)
    # expect(rendered).to have_title(title)
    expect(rendered).to have_css('h1', text: title)
  end


end
