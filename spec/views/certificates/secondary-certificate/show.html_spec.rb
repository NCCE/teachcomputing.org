require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, programme: secondary_certificate) }

  before do
    assign(:current_user, user)
    assign(:programme, secondary_certificate)
    assign(:programme_activity_groupings, programme_activity_groupings)

    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: secondary_certificate.title)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
  end

  it 'has an intro' do
    expect(rendered).to have_css('.govuk-body-m', text: 'Welcome to the Teach secondary computing programme')
  end

  it 'has the expected section titles' do
    expect(rendered).to have_text('Complete at least one online course')
    expect(rendered).to have_text('Complete at least one face to face, or remote course')
    expect(rendered).to have_text('Choose at least one activity to a group name', count: 2)
  end

  it 'has a community activity component' do
    expect(rendered).to have_css('.community-activity-component')
  end

  it 'has a course activity component' do
    expect(rendered).to have_css('.course-activity-component')
  end

  it 'has view all courses button' do
    expect(rendered).to have_link('View all certificate courses')
  end

  it 'has support information' do
    expect(rendered).to have_css('.aside-component__heading', text: 'Need some help?')
  end

  it 'has feedback form' do
    expect(rendered).to have_css('.feedback-component__heading', text: 'What can we do better?')
  end
end
