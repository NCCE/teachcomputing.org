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

  describe 'selecting a filter' do
    before do
      select('Key stage 1', from: :level)
      sleep(1)
    end

    it 'shows the expected number of results when a filter is applied' do
      expect(page).to have_css('.ncce-courses__count', text: 'Showing results')
    end

    it 'shows the clear all filters button' do
      expect(page).to have_link('Clear all filters', href: courses_path(anchor: 'results-top'))
    end

    it 'highlights the selected filter' do
      expect(page).to have_css('.filter--active', text: 'Key stage 1')
    end
  end
end
