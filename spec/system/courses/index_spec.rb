require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Courses page', type: :system) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    stub_subjects
    stub_age_groups
    stub_course_templates
    visit courses_path
  end

  it 'is the correct page' do
    expect(page).to have_content('Computing courses for teachers')
  end

  it 'is displaying the expected number of results' do
    expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
  end

  it 'does not show the toggle menu' do
    expect(page).not_to have_css('.ncce-courses__filter-form-toggle--open')
  end

  describe 'a check box', js: true do
    before do
      check('course_format_0', visible: false)
    end

    it 'shows the expected number of results when selected' do
      expect(page).to have_css('.ncce-courses__count', text: 'Showing 30 results')
    end

    it 'shows the clear all filters button' do
      expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
    end
  end

  describe 'clearing filters', js: true do
    before do
      check('course_format_1', visible: false)
      click_on('Clear all filters')
      sleep 0.5
    end

    it 'shows the expected number of results when selected' do
      expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
    end

    it 'hides the clear all filters button' do
      expect(page).not_to have_link('Clear all filters')
    end

    it 'removes filters' do
      expect(page).to have_unchecked_field('course_format_1', visible: :hidden)
    end
  end

  describe 'on a mobile device' do
    before do
      resize_window_to_mobile
    end

    it 'shows the expected number of results when selected' do
      expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
    end

    it 'shows the toggle menu' do
      expect(page).to have_css('.ncce-courses__filter-form-toggle--open')
    end

    it 'hides the toggle menu when clicked' do
      click_on('Filter courses')
      expect(page).not_to have_css('.ncce-courses__filter-form-toggle--open')
    end
  end

  describe 'on a mobile device with filter applied' do
    before do
      resize_window_to_mobile
      check('course_format_1', visible: false)
    end

    it 'shows the expected number of results when selected' do
      expect(page).to have_css('.ncce-courses__count', text: 'Showing 25 results')
    end

    it 'shows the toggle menu with the expected number of filters' do
      expect(page).to have_css('.ncce-courses__filter-form-toggle--open', text: '1 filter applied')
    end

    it 'increases the filter count when another filter is clicked' do
      check('course_format_2', visible: false)
      expect(page).to have_css('.ncce-courses__filter-form-toggle--open', text: '2 filters applied')
    end

    it 'shows the clear all filters button' do
      expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
    end
  end
end
