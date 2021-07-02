require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Courses page', type: :system) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects
    stub_age_groups
    stub_course_templates
  end

  context 'when using a desktop', js: true do
    before do
      resize_window_to_desktop
      visit courses_path
    end

    describe 'with no filters applied' do
      it 'is the correct page' do
        expect(page).to have_content('Computing courses for teachers')
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
      end

      it 'does not show the toggle menu' do
        expect(page).not_to have_css('.ncce-courses__filter-form-toggle--open')
      end
    end

    describe 'with a checkbox filter' do
      before do
        check('course_format_0', visible: false)
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 30 results')
      end

      it 'shows the clear all filters button' do
        expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
      end
    end

    describe 'with a select filter' do
      before do
        select('Key stage 1', from: 'level')
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 14 results')
      end

      it 'shows the clear all filters button' do
        expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
      end
    end

    describe 'when clearing filters' do
      before do
        check('course_format_1', visible: false)
        click_on('Clear all filters')
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
      end

      it 'hides the clear all filters button' do
        expect(page).not_to have_link('Clear all filters')
      end

      it 'removes filters' do
        expect(page).to have_unchecked_field('course_format_1', visible: :hidden)
      end
    end
  end

  context 'when using a mobile device' do
    before do
      resize_window_to_mobile
      visit courses_path
    end

    describe 'with no filters applied' do
      it 'the menu is collapsed by default' do
        expect(page).not_to have_css('.ncce-courses__filter-form-toggle--open')
      end

      it 'shows the menu when clicked' do
        click_button(class: 'ncce-courses__filter-form-toggle')
        expect(page).to have_css('.ncce-courses__filter-form-toggle--open')
      end

      it 'closes the menu when clicked twice' do
        click_button(class: 'ncce-courses__filter-form-toggle')
        expect(page).to have_css('.ncce-courses__filter-form-toggle--open')
        click_button(class: 'ncce-courses__filter-form-toggle--open')
        expect(page).not_to have_css('.ncce-courses__filter-form-toggle--open')
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 79 results')
      end
    end

    describe 'with filters applied' do
      before do
        click_button(class: 'ncce-courses__filter-form-toggle')
        check('course_format_1', visible: false)
      end

      it 'shows the expected number of results' do
        expect(page).to have_css('.ncce-courses__count', text: 'Showing 25 results')
      end

      it 'shows the expected number of filters' do
        expect(page).to have_css('.ncce-courses__filter-form-toggle-applied', text: '1 filter applied')
      end

      it 'increases the filter count when another filter is clicked' do
        check('course_format_2', visible: false)
        expect(page).to have_css('.ncce-courses__filter-form-toggle-applied', text: '2 filters applied')
      end

      it 'shows the clear all filters button' do
        expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
      end

      it 'shows the expected number of filters when the menu is closed' do
        click_button(class: 'ncce-courses__filter-form-toggle--open')
        expect(page).to have_css('.ncce-courses__filter-form-toggle-applied', text: '1 filter applied')
      end
    end
  end
end
