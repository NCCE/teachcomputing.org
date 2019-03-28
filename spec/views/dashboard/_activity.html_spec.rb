require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @achievements = user.achievements
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to the National Centre for Computing Education')
  end

  it 'check for every achievements title' do
    @achievements.each do |achievement|
      expect(rendered).to have_css('.ncce-activity-list__item-text', text: achievement.title)
    end
  end

  it 'check for every Undo link' do
    @achievements.each do |achievement|
      expect(rendered).to have_css('.ncce-activity-list__link-undo', text: 'Undo')
    end
  end

  it 'has the collapsible add form title' do
    expect(rendered).to have_css('.ncce-collapsible-activity__title-button', text: /.*Add a course you've completed.*/)
  end

  it 'has the collapsible form select' do
    expect(rendered).to have_css('.ncce-activity-form__select', count: 1)
  end

  it 'has the collapsible form button' do
    expect(rendered).to have_css('.ncce-activity-form__button--pink', count: 1)
  end
end
