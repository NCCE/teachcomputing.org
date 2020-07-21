require 'rails_helper'

RSpec.describe('curriculum/units/_tiles', type: :view) do
	let(:unit) { create(:unit ) }

  before do
    render
  end

  it 'has a tiles wrapper' do
    expect(rendered).to have_css('.curriculum__tiles', count: 1)
  end

end
