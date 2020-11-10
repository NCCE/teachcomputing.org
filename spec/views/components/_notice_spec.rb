require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'ANNOUNCEMENT')
  end

  it 'national restrictions' do
    expect(rendered).to have_link(' here for more information', href: 'https://blog.teachcomputing.org/national-restrictions/')
  end
end
