require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }

  before do
    create(:achievement, user: user)
    @achievements = user.achievements
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to NCCE')
  end

  it 'has the form item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Add a CPD Activity')
  end

  it 'has the check marks' do
    expect(rendered).to have_css('.ncce-activity-list__item-check-mark', count: 2)
  end
end
