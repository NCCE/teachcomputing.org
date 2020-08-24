require 'rails_helper'

RSpec.describe('curriculum/units/_lessons', type: :view) do
	let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }

  before do
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)
		assign(:id, 'id')
		render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-body-l', text: 'Lessons')
  end

  it 'has list of lessons' do
    expect(rendered).to have_css('.govuk-list', count: 1)
  end

end
