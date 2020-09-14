require 'rails_helper'

RSpec.describe('curriculum/lessons/show', type: :view) do
	let(:lesson_json) { File.new('spec/support/curriculum/views/lesson.json').read }
  let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }
  let(:user) { create(:user) }

  before do
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)

		json = JSON.parse(lesson_json, object_class: OpenStruct).data
		assign(:lesson, json.lesson)
		assign(:id, 'id')
  end

  it 'has a title' do
    render
    expect(rendered).to have_css('.hero__heading', text: 'Lesson 1')
  end

  context 'when a user is signed in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      render
    end

    it 'has a download button' do
      expect(rendered).to have_link('Download all lesson files', href: "https://teachcomputing.org?user_stem_achiever_contact_no=#{user.stem_achiever_contact_no}")
    end

    it 'shows the rating partial' do
      expect(rendered).to have_css('.curriculum__rating')
    end
  end

  context 'when a user is not signed in' do
    before do
      render
    end

    it 'does not have a download button' do
      expect(rendered).not_to have_link('Download all lesson files', href: 'https://teachcomputing.org')
    end

    it 'does not show the rating partial' do
      expect(rendered).not_to have_css('.curriculum__rating')
    end
  end
end
