require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do

  before do
    assign(:delegate_course_list, [])
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h2', text: 'Your Dashboard')
  end

  it 'has progress section' do
    expect(rendered).to have_css('h3', text: 'Your progress')
  end

  it 'has a link to certification' do
    expect(rendered).to have_link('certification', href: '/certification')
  end

  it 'has an aside' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end
end
