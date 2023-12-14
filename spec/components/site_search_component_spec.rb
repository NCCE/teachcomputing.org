require 'rails_helper'

RSpec.describe SiteSearchComponent, type: :component do
  before do
    render_inline(described_class.new())
  end

  it 'should have an input and a button' do
    expect(page).to have_css('input')
    expect(page).to have_css('button')
  end
end
