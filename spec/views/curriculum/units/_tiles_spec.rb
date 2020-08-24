require 'rails_helper'

RSpec.describe('curriculum/units/_tiles', type: :view) do
	let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }

  before do
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)
		assign(:id, 'id')
		render
  end

  it 'has a tiles wrapper' do
    expect(rendered).to have_css('.curriculum__tiles', count: 1)
  end

end
