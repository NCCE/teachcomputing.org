require 'rails_helper'

RSpec.describe('curriculum/units/show', type: :view) do
	let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }

  before do
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)
		assign(:id, 'id')
		render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Unit 1')
  end

  it 'has a unit label' do
    expect(rendered).to have_css('.curriculum__label', text: 'Unit')
  end

  it 'links to feedback form' do
    expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
  end
end
