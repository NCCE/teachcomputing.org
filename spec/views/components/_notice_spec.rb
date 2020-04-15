require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'COVID19')
  end

  it 'read our full statement' do
    expect(rendered).to have_link('Read our full statement', href: 'https://blog.teachcomputing.org/coronavirus-update/')
  end
end
