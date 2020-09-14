require 'rails_helper'

RSpec.describe('curriculum/units/_tiles', type: :view) do
	let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }

  before do
		unit = JSON.parse(unit_json, object_class: OpenStruct).data.unit
		render partial: 'tiles', locals: { unit: unit }
  end

  it 'has a tiles wrapper' do
    expect(rendered).to have_css('.curriculum__tiles', count: 1)
  end

end
