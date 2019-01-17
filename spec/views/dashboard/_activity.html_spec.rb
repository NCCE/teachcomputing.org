require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do

  before do
    delegate_course = double(Object, activity_title: 'Test Course')
    assign(:delegate_course_list, [delegate_course])
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to NCCE')
  end

  it 'has the mock course' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Test Course')
  end

  it 'has the form item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Add a CPD Activity')
  end

  it 'has the check marks' do
    expect(rendered).to have_css('.ncce-activity-list__item-check-mark', count: 2)
  end

end