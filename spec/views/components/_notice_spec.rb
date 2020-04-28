require 'rails_helper'

RSpec.describe('components/_notice', type: :view) do
  before do
    render
  end

  it 'has a tag' do
    expect(rendered).to have_css('.ncce-courses__tag', text: 'ANNOUNCEMENT')
  end

  it 'read our full statement' do
    expect(rendered).to have_link('Explore home learning:', href: 'https://blog.teachcomputing.org/computing-resources-for-home-learning/')
  end
end
