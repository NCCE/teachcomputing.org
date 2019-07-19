require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/_teacher_reference_number', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  context 'when user has no TRN' do
    before do
      render
    end

    it 'achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'has a form' do
      expect(rendered).to have_css('.ncce-activity-list__form', count: 1)
    end
  end

  context 'when user has their TRN' do
    before do
      user.update_attributes(teacher_reference_number: 'TRN456')
      render
    end

    it 'no achievement is marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has no form' do
      expect(rendered).to have_css('.ncce-activity-list__form', count: 0)
    end

    it 'shows the TRN' do
      expect(rendered).to have_css('.ncce-activity-list__item-activity--trn', text: 'TRN456')
    end
  end
end
