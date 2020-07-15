require 'rails_helper'

RSpec.describe('curriculum/key_stages/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Teach computing curriculum')
  end

end
