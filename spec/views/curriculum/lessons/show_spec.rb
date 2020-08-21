require 'rails_helper'

RSpec.describe('curriculum/lessons/show', type: :view) do
	let(:lesson_json) { File.new('spec/support/curriculum/views/lesson.json').read }

	let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }

  before do
		#stub_a_valid_request(unit_json_response)
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)

		json = JSON.parse(lesson_json, object_class: OpenStruct).data
		assign(:lesson, json.lesson)
		assign(:id, 'id')
		render :template => "curriculum/lessons/show.html.erb"
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Lesson 1')
  end

  it 'has a lesson label' do
    expect(rendered).to have_css('.curriculum__label', text: 'Lesson')
  end

  it 'has a download button' do
    expect(rendered).to have_link('Download all lesson files', href: 'https://teachcomputing.org')
  end

end
