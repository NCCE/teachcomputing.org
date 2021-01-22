require 'rails_helper'

RSpec.describe('curriculum/units/show', type: :view) do
  let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:unit, json.unit)
  end

  context 'when a user is not signed in' do
    before do
      setup_view
      render
    end

    it 'shows the breadcrumb partial' do
      expect(rendered).to have_link('Curriculum', href: '/curriculum')
      expect(rendered).to have_link('KS1', href: '/curriculum/key-stage-1')
      expect(rendered).to have_css('.curriculum__breadcrumb', text: 'Unit')
    end

    it 'has a title' do
      expect(rendered).to have_css('.hero__heading', text: 'Unit 1')
    end

    it 'links to feedback form' do
      expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
    end

    it 'does not show the rating partial' do
      expect(rendered).not_to have_css('.curriculum__rating')
    end
  end

  context 'when a user is signed in' do
    before do
      setup_view
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'shows the rating partial' do
      expect(rendered).to have_css('.curriculum__rating')
    end
  end
end
