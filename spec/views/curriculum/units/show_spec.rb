require 'rails_helper'

RSpec.describe('curriculum/units/show', type: :view) do
  let(:unit_json) { File.new('spec/support/curriculum/views/unit.json').read }
  let(:user) { create(:user) }

  before do
		json = JSON.parse(unit_json, object_class: OpenStruct).data
		assign(:unit, json.unit)
		assign(:id, 'id')
  end

  it 'has a title' do
    render
    expect(rendered).to have_css('.hero__heading', text: 'Unit 1')
  end

  it 'links to feedback form' do
    render
    expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
  end

  context 'when a user is signed in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      render
    end

    it 'shows the rating partial' do
      expect(rendered).to have_css('.curriculum__rating')
    end
  end

  context 'when a user is not signed in' do
    it 'shows the rating partial' do
      render
      expect(rendered).not_to have_css('.curriculum__rating')
    end
  end
end
