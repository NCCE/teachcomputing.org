require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @achievements = user.achievements
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to the NCCE')
  end

  it 'check for every achievements title' do
    @achievements.each do |achievement|
      expect(rendered).to have_css('.ncce-activity-list__item-text', text: achievement.title)
    end
  end

  it 'has the form item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Add a completed CPD Activity')
  end
end
