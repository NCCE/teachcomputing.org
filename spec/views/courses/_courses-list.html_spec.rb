require 'rails_helper'

RSpec.describe('courses/_courses-list', type: :view) do
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
  let(:subjects) { { 'Algorithmic thinking' => 100_000_011, 'Biology' => 157_430_000, 'Careers' => 157_430_001 } }
  let(:age_groups) do
    {
      'Key stage 1': 157_430_008,
      'Key stage 2': 157_430_009,
      'Key stage 3': 157_430_010,
      'Key stage 4': 157_430_011
    }
  end
  let(:certificates) do
    {
      'subject-knowledge': 'Subject Knowledge',
      'secondary-certificate': 'Secondary Certificate',
      'primary-certificate': 'Primary Certificate'
    }
  end

  describe 'when there are courses' do
    before do
      allow(filter_stub).to receive_messages(
        course_tags: { Algorithms: '101' },
        age_groups: age_groups,
        subjects: subjects,
        certificates: certificates,
        course_formats: %i[face_to_face online remote],
        current_hub: nil,
        current_level: nil,
        current_location: nil,
        current_topic: nil,
        current_certificate: nil,
        applied_filters: nil,
        total_results_count: 3,
        location_search?: false,
        non_location_based_results: courses,
      )

      @filter_params = { hub_id: 'bla' }
      @course_filter = filter_stub
      render
    end

    it 'links to the course landing page for each course' do
      courses.each do |course|
        expect(rendered).to have_link(course.title, href: %r{#{course.activity_code}/#{course.title.parameterize}})
      end
    end

    it 'hides the loading bar by default' do
      expect(rendered).to have_css('.ncce-courses__loading-bar.hidden')
    end

    it 'shows a count of results' do
      expect(rendered).to have_css('.ncce-courses__count', text: 'Showing 3 results')
    end

    it 'renders each of the course template titles' do
      courses.each do |course|
        expect(rendered).to have_css('.ncce-courses__heading', text: course.title)
      end
    end

    it 'renders each of the course template codes' do
      courses.each do |course|
        expect(rendered).to have_css('.ncce-courses__heading-code', text: course.activity_code)
      end
    end

    it 'renders course key stage tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Key stage 3')
    end

    it 'renders course subject tags area' do
      expect(rendered).to have_css('h3.screen-reader-only', text: 'Tags for this course')
    end

    it 'renders course subject tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Biology')
    end

    it 'renders the programme tag' do
      expect(rendered).to have_css('.ncce-courses__filter-tag--subject-knowledge', text: 'Subject Knowledge')
    end
  end

  describe 'when there are no courses' do
    context 'when there is no hub' do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: { Algorithms: '101' },
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          course_formats: %i[face_to_face online remote],
          current_hub: nil,
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_certificate: nil,
          applied_filters: nil,
          total_results_count: 0,
          location_search?: false,
          non_location_based_results: [],
        )
        @filter_params = {}
        @course_filter = filter_stub
        render
      end

      it 'displays the emoji' do
        expect(rendered).to have_css('.ncce-courses__sad-face')
      end

      it 'displays the expected message' do
        expect(rendered).to have_text("Sorry, we couldn't find any courses that match your filter options.")
      end
    end

    context 'when there is a hub' do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: { Algorithms: '101' },
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          course_formats: %i[face_to_face online remote],
          current_hub: 'bla',
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_certificate: nil,
          applied_filters: ['bla'],
          total_results_count: 0,
          location_search?: false,
          non_location_based_results: [],
        )
        @filter_params = { hub_id: 'bla' }
        @course_filter = filter_stub
        render
      end

      it 'does not display the emoji' do
        expect(rendered).not_to have_css('.ncce-courses__sad-face')
      end

      it 'displays the expected message' do
        expect(rendered).to have_text('Sorry, this Computing Hub is currently not running any courses.')
      end
    end
  end
end
