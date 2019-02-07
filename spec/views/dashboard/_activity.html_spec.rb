require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @achievements = user.achievements
    delegate_course = double(Object, activity_title: 'Test Course')
    assign(:delegate_course_list, [delegate_course])
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to the NCCE')
  end

  it 'has the mock course' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Completed course Test Course')
  end

  it 'has the mock course titles' do
    expect(rendered).to have_css('.ncce-activity-list__item-text', count: 2)
  end

  it 'has the form item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Add a completed CPD Activity')
  end
end
