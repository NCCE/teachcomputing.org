require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  xit 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'ANNOUNCEMENT')
  end
end
