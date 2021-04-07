require 'rails_helper'

RSpec.describe('courses/_aside-filters', type: :view) do
  let(:courses) do
    build_list(
      :achiever_course_template,
      3,
      age_groups: ['157430010'],
      subjects: ['157430000'],
      occurrences: [build(:achiever_course_occurrence)]
    )
  end
  let(:filter_stub) { instance_double(Achiever::CourseFilter) }
  let(:subjects) { { 'Algorithmic thinking': 100_000_011, Biology: 157_430_000, Careers: 157_430_001 } }
  let(:age_groups) { { 'Key stage 1': 157_430_008, 'Key stage 2': 157_430_009 } }
  let(:certificates) { { 'CS Accelerator': 'cs-accelerator' } }

  describe 'courses' do
    context 'with no filters applied' do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: { Algorithms: '101' },
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          courses: courses,
          course_formats: %i[face_to_face online remote],
          course_locations: ['Cambridge'],
          current_hub: 'bla',
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_format: [],
          current_certificate: nil,
          applied_filters: %w[bla]
        )

        @filter_params = { hub_id: 'bla' }
        @course_filter = filter_stub
        render
      end

      it 'renders a title' do
        expect(rendered).to have_text('Filter courses')
      end

      it 'does not render the filters applied count' do
        expect(rendered).to have_css('.ncce-courses__filter-form-toggle-applied.hidden')
      end

      it 'does not render the clear filters button' do
        expect(rendered).to have_css('.ncce-courses__clear-filters.hidden')
      end

      it 'renders the filter aside open by default' do
        expect(rendered).to have_css('.ncce-courses__filter-form-toggle--open')
      end

      it 'renders location select' do
        expect(rendered).to have_select(:location, with_options: ['Any location', 'Cambridge'])
      end

      it 'renders level select' do
        expect(rendered).to have_select(:level, with_options: ['Any level', 'Key stage 1', 'Key stage 2'])
      end

      it 'renders topic select' do
        expect(rendered).to have_select(:topic, with_options: ['Any topic', 'Algorithms'])
      end

      it 'renders certificate select' do
        expect(rendered).to have_select(:certificate, options: ['Any certificate', 'CS Accelerator'])
      end

      it 'renders the checkboxes' do
        expect(rendered).to have_css('.ncce-checkboxes__input', count: 3)

        expect(rendered).to have_css('.ncce-checkboxes__label', text: 'Face to face')
        expect(rendered).to have_css('.ncce-checkboxes__label', text: 'Online')
        expect(rendered).to have_css('.ncce-checkboxes__label', text: 'Remote')
      end

      it 'has a view results button' do
        expect(rendered).to have_css('.ncce-courses__view-results', text: 'View 3 results')
      end

      it 'has a submit button when js is disabled' do
        expect(rendered).to have_button('Apply filters')
      end
    end

    context 'with filters applied' do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: { Algorithms: '101' },
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          courses: courses,
          course_formats: %i[face_to_face online remote],
          course_locations: ['Cambridge'],
          current_hub: 'bla',
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_format: [],
          current_certificate: 'cs-accelerator',
          applied_filters: %w[bla cs-accelerator]
        )

        @filter_params = { hub_id: 'bla', certificate: 'cs-accelerator' }
        @course_filter = filter_stub
        render
      end

      it 'renders the filters applied count' do
        expect(rendered).not_to have_css('.ncce-courses__filter-form-toggle-applied.hidden')
        expect(rendered).to have_css('.ncce-courses__filter-form-toggle-applied', text: '1 filter applied')
      end

      it 'renders the clear all filters link' do
        expect(rendered).to have_link(
          'Clear all filters',
          href: courses_path(hub_id: 'bla', anchor: 'results-top')
        )
      end

      it 'selects the filter' do
        expect(rendered).to have_select(
          :certificate, selected: ['CS Accelerator'], options: ['Any certificate', 'CS Accelerator']
        )
      end
    end
  end
end
