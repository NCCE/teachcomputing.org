require 'rails_helper'

RSpec.describe('certificates/a_level/show', type: :view) do
  let(:user) { create(:user) }
  let(:a_level) { create(:a_level) }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 1, :with_activities, sort_key: 2, programme: a_level) }
  let(:assessment) { create(:assessment, programme: a_level) }

  before do
    stub_course_templates
    stub_duration_units

    assign(:programme, a_level)
    assign(:assessment, assessment)

    assign(:current_user, user)

    assign(:face_to_face_achievements, [])
    assign(:online_achievements, [])

    assign(:professional_development_groups, professional_development_groups)
    assign(:cpd_courses, professional_development_groups.flat_map(&:programme_activities))

    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: a_level.title)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 1)
  end

  it 'has the expected section titles' do
    expect(rendered).to have_text('Welcome to your A level Computer Science subject knowledge certificate!')
    expect(rendered).to have_text('Need more support?')
    expect(rendered).to have_text('Practice your knowledge and get your students involved')
  end

  it 'has no recommendation list' do
    expect(rendered).not_to have_css('.recommended-courses-wrapper', text: 'Courses based on your pathway')
  end

  it 'shows all activities' do
    expect(rendered).to have_css('.ncce-activity-list__item', count: 1)
  end

  it 'shows no hidden activity title' do
    expect(rendered).not_to have_text('View more activity options')
  end

  it 'has support information' do
    expect(rendered).to have_css('.aside-component__heading', text: 'Need some help?')
  end

  it 'has feedback form' do
    expect(rendered).to have_css('.feedback-component__heading', text: 'What can we do better?')
  end
end
