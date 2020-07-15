require 'rails_helper'

RSpec.describe('curriculum/lessons/show', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'L6: Using a computer responsibly')
  end

  it 'has a lesson label' do
    expect(rendered).to have_css('.curriculum__label', text: 'Lesson')
  end

  it 'has a download button' do
    expect(rendered).to have_link('Download all lesson files', href: '')
  end

end
