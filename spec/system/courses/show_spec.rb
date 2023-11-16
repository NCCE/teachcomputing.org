require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Course Details page', type: :system) do
  let(:user) { create(:user) }
  let(:course_id) { 'CP428' }
  let(:course_slug) { 'an-introduction-to-algorithms-programming-and-data-in-gcse-computer-science-remote' }
  let(:activity) { create(:activity, :stem_learning, stem_activity_code: course_id) }

  before do
    activity
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    stub_duration_units
    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects
    stub_age_groups
    stub_course_templates
    stub_attendance_sets
    stub_delegate
  end

  context 'when using a desktop', js: true do
    before do
      resize_window_to_desktop
      visit course_path(id: course_id, name: course_slug)
    end

    it 'does not have a skip button' do
      expect(page).not_to have_link('Skip to course booking')
    end
  end

  context 'when using a tablet', js: true do
    before do
      resize_window_to_tablet
      visit course_path(id: course_id, name: course_slug)
    end

    it 'does not have a skip button' do
      expect(page).not_to have_link('Skip to course booking')
    end
  end

  context 'when using a mobile' do
    before do
      resize_window_to_mobile
      visit course_path(id: course_id, name: course_slug)
    end

    it 'has a skip button' do
      expect(page).to have_link(
        'Skip to course booking',
        href: course_path(id: course_id, name: course_slug, anchor: 'booking-list')
      )
    end
  end
end
